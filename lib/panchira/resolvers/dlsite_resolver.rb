# frozen_string_literal: true

module Panchira
  class DlsiteResolver < Resolver
    URL_REGEXP = /dlsite/.freeze

    private

    def parse_image_url
      @page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
    end

    def parse_tags
      @page.css('.main_genre').children.children.map(&:text)
    end
  end

  ::Panchira::Extensions.register(Panchira::DlsiteResolver)
end
