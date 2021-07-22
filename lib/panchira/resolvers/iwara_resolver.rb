# frozen_string_literal: true

module Panchira
  class IwaraResolver < Resolver
    URL_REGEXP = /(www|ecchi)\.iwara\.tv\//.freeze

    private
      def parse_title
        super.split(' | ')[0]
      end

      def parse_image_url
        url = @page.at_css('#video-player')&.attributes['poster']&.value
        'https:' + url if url
      end

      def parse_author
        @page.at_css('.node-info .username')&.children&.[](0)&.text
      end

      def parse_tags
        @page.css('.node-info .field-item').map { |e| e.children&.text }
      end

      def cookie
        'show_adult=1'
      end

      def parse_canonical_url
        @url # canonical has relative path. ignore it
      end
  end

  ::Panchira::Extensions.register(Panchira::IwaraResolver)
end
