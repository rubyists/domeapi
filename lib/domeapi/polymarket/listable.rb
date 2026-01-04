# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Mixin for listable resources
      module Listable
        def self.included(base)
          base.extend(ClassMethods)
        end

        # Class methods for Listable
        module ClassMethods
          attr_accessor :endpoint_path

          # Set the endpoint path for the resource
          #
          # @param path [String] API endpoint path
          #
          # @return [String] endpoint path
          def polymarket_path(path)
            self.endpoint_path = path
          end

          def list(...)
            new.list(...)
          end
        end

        # List resources
        #
        # @param filter [Filter|Hash] Filter options
        #
        # @return [Hash|Array] resource data
        def list(filter = self.class::Filter.new(self.class::Filter::Properties.new))
          filter = self.class::Filter.new(self.class::Filter::Properties.new(**filter)) if filter.is_a?(Hash)
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

          client.get(self.class.endpoint_path, params: filter.to_h)
        end
      end
    end
  end
end
