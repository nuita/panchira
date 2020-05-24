# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'fastimage'
require 'json'

require_relative 'panchira/version'
require_relative 'panchira/panchira_result'
require_relative 'panchira/resolvers/resolver'
require_relative 'panchira/extensions'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + '/panchira/resolvers/*_resolver.rb').sort.each { |file| require file }

# Main Panchira code goes here.
module Panchira
  class << self
    # Fetch the given URL and returns a PanchiraResult.
    def fetch(url)
      resolver = select_resolver(url)

      resolver.new(url).fetch
    end

    private

    def select_resolver(url)
      Panchira::Extensions.resolvers.each do |resolver|
        return resolver if resolver.applicable?(url)
      end

      Panchira::Resolver
    end
  end
end
