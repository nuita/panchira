# frozen_string_literal: true

require 'net/https'

module Panchira
  module Narou
    class Novel18Resolver < Resolver
      URL_REGEXP = %r{novel18\.syosetu\.com/}.freeze
      ID_REGEXP = %{novel18\.syosetu\.com/(?<id>[^/]+)}.freeze

      def fetch_page(uri)
        u = URI.parse(uri)
        http = Net::HTTP.new(u.host, u.port)
        http.use_ssl = u.port == 443
        res = http.get u.request_uri, { 'cookie' => 'over18=yes;' }

        Nokogiri::HTML.parse(res.body, uri)
      end

      def parse_tags
        id = @url.match(ID_REGEXP)[:id]
        return [] unless id

        desc = fetch_page("https://novel18.syosetu.com/novelview/infotop/ncode/#{id}/")
        desc.xpath('//*[@id="noveltable1"]/tr[3]')&.text&.split("\n\n\n")&.dig(1)&.split(' ') # つらい。
      end
    end
    class NcodeResolver < Resolver
      URL_REGEXP = %r{ncode\.syosetu\.com}.freeze
      ID_REGEXP = %{ncode\.syosetu\.com/(?<id>[^/]+)}.freeze

      def parse_tags
        id = @url.match(ID_REGEXP)[:id]
        return [] unless id

        desc = fetch_page("https://ncode.syosetu.com/novelview/infotop/ncode/#{id}/")
        desc.xpath('//*[@id="noveltable1"]/tr[3]')&.text&.split("\n\n\n")&.dig(1)&.delete("\u00A0")&.split(' ')&.grep_v('') # めっちゃつらい。
      end
    end
  end

  ::Panchira::Extensions.register(Panchira::Narou::NcodeResolver)
  ::Panchira::Extensions.register(Panchira::Narou::Novel18Resolver)
end
