# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Orderbook API endpoints
      class Orderbook
        attr_reader :client

        # @param client [Rubyists::Domeapi::Polymarket::Client]
        #
        # @return [void]
        def initialize(client = Rubyists::Domeapi::Polymarket::Client.new)
          @client = client
        end

        # Filter for orderbook history
        class Filter < Contract
          Properties = Struct.new(
            :token_id,
            :start_time,
            :end_time,
            :limit,
            :offset,
            keyword_init: true
          )

          Properties.members.each { |member| property member, populator: ->(model:, **) { model || skip! } }

          validation do
            params do
              required(:token_id).filled(:string)
              required(:start_time).filled(:integer)
              required(:end_time).filled(:integer)
              optional(:limit).maybe(:integer, gteq?: 1, lteq?: 1000)
              optional(:offset).maybe(:integer, gteq?: 0)
            end
          end
        end

        # Get orderbook history
        #
        # @param filter [Filter] Filter options
        #
        # @return [Hash] orderbook history data
        def list(filter = Filter.new(Filter::Properties.new))
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

          client.get('markets/get_orderbook_history', params: filter.to_h)
        end
      end
    end
  end
end
