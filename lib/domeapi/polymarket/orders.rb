# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Orders API endpoints
      class Orders
        attr_reader :client

        def initialize(client)
          @client = client
        end

        # Query orders with filtering options
        # @param market_slug [String]
        # @param start_time [Integer]
        # @param end_time [Integer]
        # @param limit [Integer]
        def list(market_slug: nil, start_time: nil, end_time: nil, limit: nil)
          params = {
            market_slug:,
            start_time:,
            end_time:,
            limit:
          }.compact

          client.get('orders/get_orders', params: params)
        end
      end
    end
  end
end
