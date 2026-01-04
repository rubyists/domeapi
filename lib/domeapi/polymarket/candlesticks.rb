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
          propertize(%i[condition_id start_time end_time interval])

          validation do
            # :nocov:
            params do
              required(:condition_id).filled(:string)
              required(:start_time).filled(:integer)
              required(:end_time).filled(:integer)
              optional(:interval).maybe(:integer, gteq?: 1, lteq?: 1440)
            end
            # :nocov:
          end
        end
      end
    end
  end
end
