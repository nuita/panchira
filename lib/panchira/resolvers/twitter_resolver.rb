require 'twitter-text'

module Panchira
  class TwitterResolver < Resolver
    include Twitter::TwitterText::Extractor

    URL_REGEXP = /twitter.com\/\w+\/status\/\d+/.freeze

    private
      def parse_title
        @title = super
      end

      def parse_author
        @title.match(/\A(.+) on Twitter\z/)[1]
      end

      def parse_description
        @description = super.gsub(/\A“|”\z/, '')
      end

      def parse_tags
        extract_hashtags(@description)
      end
  end

  ::Panchira::Extensions.register(Panchira::TwitterResolver)
end
