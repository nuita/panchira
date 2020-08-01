# frozen_string_literal: true

require 'net/https'

module Panchira
  module Fanza
    class FanzaBookResolver < Resolver
      URL_REGEXP = %r{book\.dmm\.co\.jp\/}.freeze
      COOKIE = 'age_check_done=1;'

      def parse_image
        @page.css('.m-imgDetailProductPack/@src').first.to_s
      end
    end
  end

  ::Panchira::Extensions.register(Panchira::Fanza::FanzaBookResolver)
end
