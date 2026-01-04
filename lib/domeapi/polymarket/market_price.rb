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
          Properties = Struct.new(
            :token_id,
            :at_time,
            keyword_init: true
          )

          Properties.members.each { |member| property member, populator: ->(value:, **) { value || skip! } }

          validation do
            params do
              required(:token_id).filled(:string)
              optional(:at_time).maybe(:integer)
            end
          end
        end
      end
    end
  end
end
