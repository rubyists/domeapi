# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Orderbook API endpoints
      class Orderbook < Endpoint
        include Listable

        polymarket_path 'markets/get_orderbook_history'

        # Filter for orderbook history
        class Filter < Contract
          propertize(%i[token_id start_time end_time limit offset])

          validation do
            # :nocov:
            params do
              required(:token_id).filled(:string)
              required(:start_time).filled(:integer)
              required(:end_time).filled(:integer)
              optional(:limit).maybe(:integer, gteq?: 1, lteq?: 1000)
              optional(:offset).maybe(:integer, gteq?: 0)
            end
            # :nocov:
          end
        end
      end
    end
  end
end
