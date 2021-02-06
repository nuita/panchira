# frozen_string_literal: true

module Panchira
  # Resolver is a class that actually get attributes by fetching designated url.
  # This class is the default resolver for pages. <br>
  # To create your own resolver, first you make a class that extends Resolver,
  # and then register it by ::Panchira::Extensions::register().
  # Then ::Panchira::fetch will pick up your resolver when Resolver::applicable?() is true.
  class Resolver
    # URL pattern that a resolver tries to resolve.
    # You must override this in subclasses to limit which urls to resolve.
    URL_REGEXP = URI::DEFAULT_PARSER.make_regexp

    def initialize(url)
      @url = url
    end

    # This function is called right after this Resolver instance is made.
    # Fetch page from @url and return PanchiraResult.
    def fetch
      result = PanchiraResult.new

      @page = fetch_page(@url)
      result.canonical_url = parse_canonical_url

      @page = fetch_page(result.canonical_url) if @url != result.canonical_url

      result.title = parse_title
      result.description = parse_description
      result.image = parse_image
      result.tags = parse_tags
      if respond_to?(:parse_authors, true)
        result.authors = parse_authors
      else
        result.author = parse_author
      end
      result.circle = parse_circle
      result.resolver = parse_resolver

      result
    end

    class << self
      # Tell whether the url is applicable for this resolver.
      # ::Panchira::fetch uses this method to choose a Resolver for a URL.
      def applicable?(url)
        url =~ self::URL_REGEXP
      end
    end

    private

      def fetch_page(url)
        read_options = {
          'User-Agent' => user_agent,
          'Cookie' => cookie
        }

        raw_page = URI.parse(url).read(read_options)
        charset = raw_page.charset
        Nokogiri::HTML.parse(raw_page, url, charset)
      end

      def parse_canonical_url
        history = []

        # fetch page and refresh canonical_url until canonical_url converges.
        loop do
          url_in_res = @page.css('//link[rel="canonical"]/@href').to_s

          if url_in_res.empty?
            return history.last || @url
          else
            if history.include?(url_in_res) || history.length > 5
              return url_in_res
            else
              history.push(url_in_res)
              @page = fetch_page(url_in_res)
            end
          end
        end
      end

      def parse_title
        if @page.css('//meta[property="og:title"]/@content').empty?
          @page.title.to_s
        else
          @page.css('//meta[property="og:title"]/@content').to_s
        end
      end

      def parse_description
        if @page.css('//meta[property="og:description"]/@content').empty?
          @page.css('//meta[name$="description"]/@content').to_s
        else
          @page.css('//meta[property="og:description"]/@content').to_s
        end
      end

      def parse_image
        image = PanchiraImage.new
        image.url = parse_image_url
        image.width, image.height = FastImage.size(image.url)

        image
      end

      def parse_image_url
        @page.css('//meta[property="og:image"]/@content').first.to_s
      end

      def parse_tags
        []
      end

      def cookie
        ''
      end

      def parse_author
        @page.css('//meta[name="author"]/@content').first.to_s
      end

      def parse_circle
        nil
      end

      def parse_resolver
        self.class.to_s
      end

      def user_agent
        "Mozilla/5.0 (compatible; PanchiraBot/#{VERSION}; +https://github.com/nuita/panchira)"
      end
  end
end
