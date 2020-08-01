# frozen_string_literal: true

require 'net/https'

module Panchira
  class FanzaResolver < Resolver
    URL_REGEXP = /dmm\.co\.jp/.freeze
    COOKIE = 'age_check_done=1;'
  end

  ::Panchira::Extensions.register(Panchira::FanzaResolver)
end
