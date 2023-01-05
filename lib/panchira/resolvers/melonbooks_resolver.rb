# frozen_string_literal: true

module Panchira
  class MelonbooksResolver < Resolver
    URL_REGEXP = /melonbooks.co.jp\/detail\/detail.php\?product_id=(\d+)/.freeze

    def fetch
      result = PanchiraResult.new

      @page = fetch_page(@url)
      result.canonical_url = parse_canonical_url

      @page = fetch_page(result.canonical_url) if @url != result.canonical_url

      result.title = parse_title
      result.author, result.circle = parse_table
      result.description = parse_description
      result.image = parse_image
      result.resolver = parse_resolver
      result.tags = parse_tags

      result
    end

    private

      def parse_table
        author, circle = nil, nil

        @page.css('div.table-wrapper > table > tr').each do |tr|
          case tr.css('th').text
          when 'サークル名'
            circle = tr.css('td > a').text.match(/^(.+)\W\(作品数:/)&.values_at(1)&.first
          when '作家名'
            author = tr.css('td > a').text.strip
          end
        end

        [author, circle]
      end

      def parse_title
        @page.xpath('//h1[@class="page-header"]//text()').text
      end

      def parse_canonical_url
        product_id = @url.slice(URL_REGEXP, 1)
        "https://www.melonbooks.co.jp/detail/detail.php?product_id=#{product_id}&adult_view=1"
      end

      def parse_description
        @page.css('div.item-detail > div > p').first.text.strip
      end

      def parse_image_url
        url = @page.css('//meta[property="og:image"]/@content').first.to_s
        image = url.match(/resize_image.php\?image=([^&]+)/)[1]

        "https://melonbooks.akamaized.net/user_data/packages/resize_image.php?image=#{image}"
      end

      def parse_tags
        @page.css('div.item-detail2 > p > a').map { |m| m.text.sub('#', '') }
      end
  end

  ::Panchira::Extensions.register(Panchira::MelonbooksResolver)
end
