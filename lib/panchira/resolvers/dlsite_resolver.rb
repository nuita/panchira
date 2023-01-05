# frozen_string_literal: true

module Panchira
  class DlsiteResolver < Resolver
    URL_REGEXP = /dlsite/.freeze

    private

      # DLSiteのタイトルの[]に含まれている値はtitleタグだとサークル名 or 出版社名だが、
      # Panchiraが優先するog:titleではサークル名 or 著者名 となる。
      # 取得に際しては、以下の3パターンを考慮する必要があるため、titleタグとtableの解析が必要となる:
      # 1) 同人系の一部, 特に音声など。タイトル[サークル名]. 本文中に著者・作者の記載なし
      # 2) 同人系の一部, 特に一部の同人誌など。タイトル[サークル名]. 本文中に「作者」の記載あり
      # 3) 商業系。タイトル[著者名]　サークル名なし
      # 込み入った実装になってしまったため、parse自体をいじる必要があるかも
      def parse_title
        @title_md = super.match(/(.+) \[(.+)\] \|.+/)
        @title_md[1]
      end

      def parse_description
        super.split('「DLsite').first
      end

      def parse_authors
        @page.css('table[id*="work_"] tr').each do |tr|
          next unless tr.css('th').text =~ /(作|著)者/

          return @authors = tr.css('td > a').map do |node|
            node.text.strip
          end
        end

        @authors = nil
      end

      def parse_circle
        @title_md[2] if @authors&.slice(0..2)&.join(' ') != @title_md[2]
      end

      def parse_image_url
        @page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
      end

      def parse_tags
        @page.css('table[id*="work_"] tr').each do |tr|
          next unless tr.css('th').text =~ /ジャンル/

          return tr.css('td a').map do |node|
            node.text.strip
          end
        end
      end

      def parse_canonical_url
        super[%r{^.+/product_id/[^/]+}]
      end
  end

  ::Panchira::Extensions.register(Panchira::DlsiteResolver)
end
