# frozen_string_literal: true

module Panchira
  class PixivResolver < Resolver
    URL_REGEXP = %r{pixiv\.net/(member_illust.php?.*illust_id=|artworks/)(\d+)}.freeze

    def initialize(url)
      super(url)
      @illust_id = url.slice(URL_REGEXP, 2)

      raw_json = URI.parse("https://www.pixiv.net/ajax/illust/#{@illust_id}").read('User-Agent' => user_agent)
      @json = JSON.parse(raw_json)
    end

    private

    def parse_title
      @json['body']['title']
    end

    def parse_author
      @json['body']['userName']
    end

    def parse_canonical_url
      'https://pixiv.net/member_illust.php?mode=medium&illust_id=' + @illust_id
    end

    def parse_image_url
      proxy_url = "https://pixiv.cat/#{@illust_id}.jpg"

      case Net::HTTP.get_response(URI.parse(proxy_url))
      when Net::HTTPNotFound
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

  ::Panchira::Extensions.register(Panchira::PixivResolver)
end
