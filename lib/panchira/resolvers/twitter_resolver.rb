# frozen_string_literal: true

module Panchira
  class TwitterResolver < Resolver
    URL_REGEXP = %r{twitter.com}.freeze
    USER_AGENT = "facebookexternalhit/1.1 (compatible; Panchira/#{VERSION}; +https://github.com/nuita/panchira)"
  end

  ::Panchira::Extensions.register(Panchira::TwitterResolver)
end
