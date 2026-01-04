# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Markets API endpoints
      class Markets < Endpoint
        include Listable

        polymarket_path 'markets'

        # Filter for Polymarket markets,
        # from https://docs.domeapi.io/api-reference/endpoint/get-markets
        class Filter < Contract
          propertize(%i[market_slug event_slug condition_id tags status min_volume limit offset start_time end_time])

          validation do
            params do
              optional(:status).maybe(:string, included_in?: %w[open closed])
              optional(:offset).maybe(:integer, gteq?: 0, lteq?: 100)
            end
          end
        end

        # Fetch current or historical price for a market
        #
        # @param token_id [String]
        # @param at_time [Integer] optional timestamp
        #
        # @return [Hash] market price data
        def price(token_id:, at_time: nil)
          params = { token_id: token_id }
          params[:at_time] = at_time if at_time
          client.get('markets/get_market_price', params: params)
        end
      end
    end
  end
end
