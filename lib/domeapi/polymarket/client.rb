# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Polymarket API Client
      class Client
        attr_reader :client

        def initialize(client = Rubyists::Domeapi::Client.new)
          @client = client
          client.prefix = 'polymarket'
        end

        def get(...)
          client.get(...)
        end

        def markets
          @markets ||= Markets.new(client)
        end

        def candlesticks
          @candlesticks ||= Candlesticks.new(client)
        end

        def trade_history
          @trade_history ||= TradeHistory.new(client)
        end

        def orderbook
          @orderbook ||= Orderbook.new(client)
        end
      end
    end
  end
end
