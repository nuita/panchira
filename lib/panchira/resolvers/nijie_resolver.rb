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
        str = @page.css('//script[@type="application/ld+json"]/text()').first.to_s

        if s = str.match(%r{https://pic.nijie.(net|info)/(?<servername>\d+)/[^/]+/nijie_picture/(?<imagename>[^"]+)})
          # 動画は容量大きすぎるし取らない
          if s[:imagename] =~ /(jpg|png)/
            'https://pic.nijie.net/' + s[:servername] + '/nijie_picture/' + s[:imagename]
          else
            s[0]
          end
        else
          @page.css('//meta[property="og:image"]/@content').first.to_s
        end
      end

      def parse_tags
        @page.css('#view-tag span.tag_name').map(&:text)
      end
  end

  ::Panchira::Extensions.register(Panchira::NijieResolver)
end
