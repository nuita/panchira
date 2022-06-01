# frozen_string_literal: true

module Panchira
  class PixivResolver < Resolver
    URL_REGEXP = %r{pixiv\.net/.*(member_illust.php?.*illust_id=|artworks/)(\d+)}.freeze

    def initialize(url, options = nil)
      super(url, options)
      @illust_id = url.slice(URL_REGEXP, 2)

      raw_json = URI.parse("https://www.pixiv.net/ajax/illust/#{@illust_id}").read('User-Agent' => user_agent)
      @json = JSON.parse(raw_json)

      @fetch_raw_image_url = options&.dig(:pixiv, :fetch_raw_image_url)
    end

    private

      def parse_title
        @json['body']['title']
      end

      def parse_author
        @json['body']['userName']
      end

      def parse_canonical_url
        "https://pixiv.net/member_illust.php?mode=medium&illust_id=#{@illust_id}"
      end

      def parse_image
        image = PanchiraImage.new
        image.url = parse_image_url
        image.width, image.height = FastImage.size(image.url, http_header: {'Referer' => 'https://app-api.pixiv.net/'})

        image
      end

      def parse_image_url
        if @fetch_raw_image_url
          return @json['body']['urls']['original']
        end

        proxy_url = "https://pixiv.cat/#{@illust_id}.jpg"

        case res = Net::HTTP.get_response(URI.parse(proxy_url))
        when Net::HTTPMovedPermanently
          # 301が返された場合、locationで渡されたURIにホストが含まれず扱いづらいため決め打ちする
          proxy_url = "https://pixiv.cat/#{@illust_id}-1.jpg"
        end

        proxy_url
      rescue StandardError
        @page.css('//meta[property="og:image"]/@content').first.to_s
      end

      def parse_tags
        @json['body']['tags']['tags'].map { |content| content['tag'] }
      end
  end

  class PixivNovelResolver < Resolver
    URL_REGEXP = %r{pixiv\.net/novel/show.php\?id=(\d+)}.freeze

    def initialize(url, options = nil)
      super(url, options)
      @novel_id = url.slice(URL_REGEXP, 1)

      raw_json = URI.parse("https://www.pixiv.net/ajax/novel/#{@novel_id}").read('User-Agent' => user_agent)
      @json = JSON.parse(raw_json)
    end

    private

      def parse_title
        @json['body']['title']
      end

      def parse_author
        @json['body']['userName']
      end

      def parse_tags
        @json['body']['tags']['tags'].map { |content| content['tag'] }
      end
  end

  ::Panchira::Extensions.register(Panchira::PixivResolver)
  ::Panchira::Extensions.register(Panchira::PixivNovelResolver)
end
