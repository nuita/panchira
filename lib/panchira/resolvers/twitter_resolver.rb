# frozen_string_literal: true

module Panchira
  class TwitterResolver < Resolver
    URL_REGEXP = %r{twitter.com}.freeze
    USER_AGENT = "Mozilla/5.0 (compatible; PanchiraBot/#{VERSION}; +https://github.com/nuita/panchira)"
  end

  ::Panchira::Extensions.register(Panchira::TwitterResolver)
end
