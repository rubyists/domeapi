# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Market Price API endpoints
      class MarketPrice < Endpoint
        include Listable

        polymarket_path 'markets/get_market_price'

        # Filter for market price
        class Filter < Contract
          propertize(%i[token_id at_time])

          validation do
            # :nocov:
            params do
              required(:token_id).filled(:string)
              optional(:at_time).maybe(:integer)
            end
            # :nocov:
          end
        end
      end
    end
  end
end
