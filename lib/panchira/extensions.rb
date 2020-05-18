# frozen_string_literal: true

module Panchira
  module Extensions
    @resolvers = []

    class << self
      # Register a resolver class which extends Panchira::Resolver.
      def register(resolver)
        @resolvers.push(resolver) unless @resolvers.include?(resolver)
      end

      attr_reader :resolvers
    end
  end
end
