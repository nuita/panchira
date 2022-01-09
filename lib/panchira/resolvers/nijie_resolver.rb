# frozen_string_literal: true

module Panchira
  class NijieResolver < Resolver
    URL_REGEXP = /nijie.*view.*id=\d+/.freeze

    private

      def parse_title
        full_title = super
        @md = full_title.match(/\A(?<title>.+) \| (?<author>.+)\z/)

        @md[:title]
      end

      def parse_author
        @md[:author]
      end

      def parse_description
        @page.css('p.illust_description')&.first&.text&.strip
      end

      def parse_canonical_url
        @url.sub(/sp.nijie/, 'nijie').sub(/view_popup/, 'view')
      end

      def parse_image_url
        str = @page.css('//script[@type="application/ld+json"]/text()').first.to_s.split.join(' ')
        thumbnail_url = JSON.parse(str)['thumbnailUrl']

        # thumbnail_urlが存在しないか、gif画像など動画の場合はロゴ画像を返す
        unless thumbnail_url
          return @page.css('//meta[property="og:image"]/@content').first.to_s
        end

        if md = thumbnail_url.match(%r{pic.nijie.net/\w+(?<resolution>/\w+/)nijie.+\.(?<format>png|jpg|jpeg)})
          thumbnail_url.sub(md[:resolution], '/')
        else
          thumbnail_url
        end
      end

      def parse_tags
        @page.css('#view-tag span.tag_name').map(&:text)
      end
  end

  ::Panchira::Extensions.register(Panchira::NijieResolver)
end
