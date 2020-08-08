# frozen_string_literal: true

require 'net/https'

module Panchira
  module Fanza
    FANZA_COOKIE = 'age_check_done=1;'

    class FanzaResolver < Resolver
      private

      def cookie
        ::Panchira::Fanza::FANZA_COOKIE
      end
    end

    class FanzaBookResolver < FanzaResolver
      URL_REGEXP = %r{book\.dmm\.co\.jp\/}.freeze

      private

      def parse_image_url
        @page.css('.m-imgDetailProductPack/@src').first.to_s
      end

      def parse_tags
        @page.css('.m-boxDetailProductInfo__list__description__item > a').map(&:text)
      end

      def parse_description
        @page.css('.m-boxDetailProduct__info__story').first&.text.to_s.gsub(/[\n\t]/, '')
      end
    end

    class FanzaDoujinResolver < FanzaResolver
      URL_REGEXP = %r{dmm\.co\.jp\/dc\/doujin\/}.freeze

      private

      def parse_tags
        @page.css('.genreTag__item').map { |t| t.text.strip }
      end
    end
  end

  ::Panchira::Extensions.register(Panchira::Fanza::FanzaBookResolver)
  ::Panchira::Extensions.register(Panchira::Fanza::FanzaDoujinResolver)
end
