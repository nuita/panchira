# frozen_string_literal: true

module Panchira
  class NijieResolver < Resolver

    private

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
  end
end
