# frozen_string_literal: true

module Panchira
  class ImageResolver < Resolver
    URL_REGEXP = %r{\.(png|gif|jpg|jpeg|webp)$}.freeze

    def fetch
      result = PanchiraResult.new
      result.canonical_url = @url
      result.image = PanchiraImage.new
      result.image.url = @url
      result
    end
  end

  ::Panchira::Extensions.register(Panchira::ImageResolver)
end
