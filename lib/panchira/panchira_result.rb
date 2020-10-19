# frozen_string_literal: true

module Panchira
  # Image attributes in PanchiraResult.
  class PanchiraImage
    attr_accessor :url, :width, :height
  end

  # Result class for Panchira.fetch.
  class PanchiraResult
    attr_accessor :canonical_url, :title, :description, :image, :tags, :author
  end
end
