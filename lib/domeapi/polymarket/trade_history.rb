# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Trade History API endpoints
      class TradeHistory < Endpoint
        include Listable

        polymarket_path 'markets/get_trade_history'

        attr_reader :client

        # Filter for trade history
        class Filter < Contract
          propertize(%i[market_slug condition_id token_id start_time end_time limit offset user])

          validation do
            # :nocov:
            params do
              optional(:market_slug).maybe(:string)
              optional(:condition_id).maybe(:string)
              optional(:token_id).maybe(:string)
              optional(:start_time).maybe(:integer)
              optional(:end_time).maybe(:integer)
              optional(:limit).maybe(:integer, gteq?: 1, lteq?: 1000)
              optional(:offset).maybe(:integer, gteq?: 0)
              optional(:user).maybe(:string)
            end
            # :nocov:
          end
        end
      end
    end
  end
end
