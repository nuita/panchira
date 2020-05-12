# frozen_string_literal: true

# Resolver is a class that actually GET url and resolve attributes.
# This class is the default resolver for pages,
# and is inherited by the other resolvers.
module Panchira
  class Resolver
    def initialize(url)
      @url = url

      raw_page = URI.parse(url).read
      charset = raw_page.charset
      @page = Nokogiri::HTML.parse(raw_page, url, charset)
    end

    def fetch
      attributes = {}

      attributes[:canonical_url] = parse_canonical_url
      attributes[:title] = parse_title
      attributes[:description] = parse_description
      attributes[:image] = parse_image

      attributes
    end

    private

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
      image = {}
      image[:url] = @page.css('//meta[property="og:image"]/@content').first.to_s
      image[:width], image[:height] = FastImage.size(image[:url])

      image
    end
  end
end
