# frozen_string_literal: true

module Rubyists
  module Domeapi
    # Namespace for Polymarket-related functionality
    module Polymarket
    end
  end
end

require_relative 'polymarket/endpoint'
require_relative 'polymarket/listable'
require_relative 'polymarket/markets'
require_relative 'polymarket/candlesticks'
require_relative 'polymarket/trade_history'
require_relative 'polymarket/orderbook'
require_relative 'polymarket/activity'
require_relative 'polymarket/market_price'
require_relative 'polymarket/wallet'
require_relative 'polymarket/wallet_profit_and_loss'
