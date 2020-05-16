# frozen_string_literal: true

require 'net/https'

module Panchira
  class NarouResolver < Resolver
    URL_REGEXP = %r{novel18\.syosetu\.com/}.freeze

    def fetch_page(uri)
      u = URI.parse(uri)
      http = Net::HTTP.new(u.host, u.port)
      http.use_ssl = u.port == 443
      res = http.get u.request_uri, { 'cookie' => 'over18=yes;' }

      Nokogiri::HTML.parse(res.body, uri)
    end
  end
end
