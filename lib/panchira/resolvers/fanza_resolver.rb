# frozen_string_literal: true

require 'net/https'

module Panchira
  module Fanza
    class FanzaBookResolver < Resolver
      URL_REGEXP = %r{book\.dmm\.co\.jp\/}.freeze

      private

      def parse_image_url
        @page.css('.m-imgDetailProductPack/@src').first.to_s
      end

      def cookie
        'age_check_done=1;'
      end
    end
  end

  ::Panchira::Extensions.register(Panchira::Fanza::FanzaBookResolver)
end
