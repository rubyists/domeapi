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

        def activity
          @activity ||= Activity.new(client)
        end

        def market_price
          @market_price ||= MarketPrice.new(client)
        end

        def wallet
          @wallet ||= Wallet.new(client)
        end

        def wallet_profit_and_loss
          @wallet_profit_and_loss ||= WalletProfitAndLoss.new(client)
        end
      end
    end
  end
end
