# frozen_string_literal: true

module Panchira
  # KomifloResolver resolves Komiflo.
  # Komiflo has its API server, so we can utilize it.
  class KomifloResolver < Resolver
    URL_REGEXP = %r{komiflo\.com(?:/#!)?/comics/(\d+)}.freeze

    def initialize(url)
      @url = url

      @id = url.slice(URL_REGEXP, 1)
      raw_json = URI.parse("https://api.komiflo.com/content/id/#{@id}").read('User-Agent' => user_agent)
      @json = JSON.parse(raw_json)
    end

    private

    def parse_title
      @json['content']['data']['title']
    end

    def parse_image_url
      'https://t.komiflo.com/564_mobile_large_3x/' + @json['content']['named_imgs']['cover']['filename']
    end

    def parse_author
      @json['content']['attributes']['artists']['children'][0]['data']['name']
    end

    def parse_description
      @json['content']['parents'][0]['data']['title']
    end

    def parse_canonical_url
      id = @url.slice(%r{komiflo\.com(?:/#!)?/comics/(\d+)}, 1)
      'https://komiflo.com/comics/' + id
    end

    def parse_tags
      @json['content']['attributes']['tags']['children'].map { |content| content['data']['name'] }
    end
  end

  ::Panchira::Extensions.register(Panchira::KomifloResolver)
end
