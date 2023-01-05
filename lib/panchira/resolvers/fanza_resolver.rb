# frozen_string_literal: true

require 'net/https'

module Panchira
  module Fanza
    FANZA_COOKIE = 'age_check_done=1;'

    class FanzaResolver < Resolver
      private

        def cookie
          ::Panchira::Fanza::FANZA_COOKIE
        end
    end

    class FanzaBookResolver < FanzaResolver
      URL_REGEXP = %r{book\.dmm\.co\.jp/}.freeze

      private

        def after_fetch
          text = @page.css('//script[type="application/ld+json"]').first.text
          @schema = JSON.parse(text)
        end

        def parse_title
          @schema['name']
        end

        def parse_authors
          @schema['subjectOf']['author']['name']
        end

        def parse_image_url
          @schema['image'].sub('ps.', 'pl.')
        end

        def parse_tags
          @schema['subjectOf']['genre']
        end

        def parse_description
          @schema['description']
        end
    end

    class FanzaDoujinResolver < FanzaResolver
      URL_REGEXP = %r{dmm\.co\.jp/dc/doujin/}.freeze

      private

        # canonical urlに別サービス(FANZA GAMES)のURLが設定されていることがあるため、
        # 別サービスの場合はとりあえず元URLを設定する
        def parse_canonical_url
          @url
        end

        def parse_circle
          @page.css('a.circleName__txt').first.text
        end

        def parse_tags
          @page.css('.genreTag__item').map { |t| t.text.strip }
        end
    end

    class FanzaVideoResolver < FanzaResolver
      URL_REGEXP = %r{www.dmm.co.jp/digital/}.freeze

      private

        def parse_title
          # og:titleは文字数制限で短く切られてる
          @page.title.match(/(.+)- \S+ - FANZA動画/)[1]&.strip || super
        end

        def parse_image_url
          super.sub(/(pr|ps).jpg$/, 'pl.jpg')
        end
    end
  end

  ::Panchira::Extensions.register(Panchira::Fanza::FanzaBookResolver)
  ::Panchira::Extensions.register(Panchira::Fanza::FanzaDoujinResolver)
  ::Panchira::Extensions.register(Panchira::Fanza::FanzaVideoResolver)
end
