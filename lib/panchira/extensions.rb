# frozen_string_literal: true

module Panchira
  # This Module manages Resolver classes.
  # To enable your own Resolver, you need to call Extensions::register().
  module Extensions
    @resolvers = []

    class << self
      # Register a given Resolver to Extensions::Resolvers.
      def register(resolver)
        @resolvers.push(resolver) unless @resolvers.include?(resolver)
      end

      # Panchira::fetch will find a correct Resolver based on this list.
      attr_reader :resolvers
    end
  end
end
