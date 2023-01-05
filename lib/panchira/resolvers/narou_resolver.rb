# frozen_string_literal: true

require 'net/https'

module Panchira
  module Narou
    class Novel18Resolver < Resolver
      URL_REGEXP = /novel18\.syosetu\.com\//.freeze
      ID_REGEXP = %{novel18\.syosetu\.com/(?<id>[^/]+)}

      def initialize(url, options = nil)
        super(url, options)

        if id = @url.match(ID_REGEXP)[:id]
          @desc = fetch_page("https://novel18.syosetu.com/novelview/infotop/ncode/#{id}/")
        end
      end

      def fetch_page(uri)
        u = URI.parse(uri)
        http = Net::HTTP.new(u.host, u.port)
        http.use_ssl = u.port == 443
        res = http.get u.request_uri, {'cookie' => 'over18=yes;'}

        Nokogiri::HTML.parse(res.body, uri)
      end

      def parse_description
        @desc&.xpath('//*[@id="noveltable1"]/tr/td')&.first&.text&.strip
      end

      def parse_author
        @desc&.xpath('//*[@id="noveltable1"]/tr[2]/td')&.text&.strip
      end

      def parse_tags
        # つらい。
        @desc&.xpath('//*[@id="noveltable1"]/tr[3]')&.text&.split("\n\n\n")&.dig(1)&.split(' ')
      end

      # og:urlで指定されたncode.syosetu.com/~~~にアクセスすると301で戻されるので何もしない
      def parse_canonical_url
        @url
      end
    end

    class NcodeResolver < Resolver
      URL_REGEXP = /ncode\.syosetu\.com/.freeze
      ID_REGEXP = %{ncode\.syosetu\.com/(?<id>[^/]+)}

      def initialize(url, options = nil)
        super(url, options)

        if id = @url.match(ID_REGEXP)[:id]
          @desc = fetch_page("https://novel18.syosetu.com/novelview/infotop/ncode/#{id}/")
        end
      end

      def parse_description
        @desc&.xpath('//*[@id="noveltable1"]/tr/td')&.first&.text&.strip
      end

      def parse_author
        @desc&.xpath('//*[@id="noveltable1"]/tr[2]/td')&.text&.strip
      end

      def parse_tags
        # めっちゃつらい。
        @desc&.xpath('//*[@id="noveltable1"]/tr[3]')&.text&.split("\n\n\n")&.dig(1)&.delete("\u00A0")&.split(' ')&.grep_v('')
      end

      # og:urlで指定されたncode.syosetu.com/~~~にアクセスすると301で戻されるので何もしない
      def parse_canonical_url
        @url
      end
    end
  end

  ::Panchira::Extensions.register(Panchira::Narou::NcodeResolver)
  ::Panchira::Extensions.register(Panchira::Narou::Novel18Resolver)
end
