# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Candlesticks API endpoints
      class Candlesticks < Endpoint
        include Listable

        polymarket_path 'markets/get_candlesticks'

        # Filter for listing candlesticks,
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
        # @return [Candlestick] The candlestick data
        # def list(filter = Filter.new(Filter::Properties.new))
        #   filter = Filter.new(Filter::Properties.new(**filter)) if filter.is_a?(Hash)
        #   raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.valid?
        #
        #   client.get('markets/get_candlesticks', params: filter.to_h)
        # end
      end
    end
  end
end
