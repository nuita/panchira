# frozen_string_literal: true

# Resolver is a class that actually GET url and resolve attributes.
# This class is the default resolver for pages,
# and is inherited by the other resolvers.
module Panchira
  class Resolver
    # The URL pattern that this resolver tries to resolve.
    # Should be redefined in subclasses.
    URL_REGEXP = URI::DEFAULT_PARSER.make_regexp

    USER_AGENT = "Mozilla/5.0 (compatible; Panchira/#{VERSION}; +https://github.com/nuita/panchira)"

    def initialize(url)
      @url = url
    end

    def fetch
      result = PanchiraResult.new

      @page = fetch_page(@url)
      result.canonical_url = parse_canonical_url

      @page = fetch_page(result.canonical_url) if @url != result.canonical_url

      result.title = parse_title
      result.description = parse_description
      result.image = parse_image
      result.tags = parse_tags

      result
    end

    class << self
      # Tell whether the url is applicable for this resolver.
      def applicable?(url)
        url =~ self::URL_REGEXP
      end
    end

    private

    def fetch_page(url)
      raw_page = URI.parse(url).read('User-Agent' => USER_AGENT)
      charset = raw_page.charset
      Nokogiri::HTML.parse(raw_page, url, charset)
    end

    def parse_canonical_url
      if (canonical_url = @page.css('//link[rel="canonical"]/@href')).any?
        canonical_url.to_s
      else
        @url
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
  end
end
