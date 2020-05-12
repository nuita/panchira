# frozen_string_literal: true

module Panchira
  class DlsiteResolver < Resolver
    private

    def parse_image_url
      @page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
    end
  end
end
