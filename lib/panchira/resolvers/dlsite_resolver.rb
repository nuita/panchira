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
        @title_md = super.match(/(.+) \[(\S+)\] \|.+/)
        @title_md[1]
      end

      def parse_author
        @page.css('table[id*="work_"] tr').each do |tr|
          if tr.css('th').text =~ /(作|著)者/
            return @author = tr.css('td > a').first.text.strip
          end
        end

        @author = nil
      end

      def parse_circle
        @title_md[2] if @author != @title_md[2]
      end

      def parse_image_url
        @page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
      end

      def parse_tags
        @page.css('.main_genre').children.children.map(&:text)
      end
  end

  ::Panchira::Extensions.register(Panchira::DlsiteResolver)
end
