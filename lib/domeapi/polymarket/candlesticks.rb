# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Candlesticks API endpoints
      class Candlesticks
        attr_reader :client

        # @param client [Rubyists::Domeapi::Polymarket::Client]
        #
        # @return [void]
        def initialize(client = Rubyists::Domeapi::Polymarket::Client.new)
          @client = client
        end

        # Filter for candlestick data,
        # from https://docs.domeapi.io/api-reference/endpoint/get-candlesticks
        class Filter < Contract
          Properties = Struct.new(
            :condition_id,
            :start_time,
            :end_time,
            :interval,
            keyword_init: true
          )

          Properties.members.each { |member| property member, populator: ->(value:, **) { value || skip! } }

          validation do
            params do
              required(:condition_id).filled(:string)
              required(:start_time).filled(:integer)
              required(:end_time).filled(:integer)
              optional(:interval).maybe(:integer, gteq?: 1, lteq?: 1440)
            end
          end
        end

        # Get OHLC candlesticks
        #
        # @param filter [Filter] Filter options
        #
        # @return [Hash] candlestick data
        def list(filter = Filter.new(Filter::Properties.new))
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.valid?

          client.get('markets/get_candlesticks', params: filter.to_h)
        end
      end
    end
  end
end
