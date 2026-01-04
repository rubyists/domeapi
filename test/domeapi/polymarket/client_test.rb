# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Polymarket::Client do
  it 'initializes with default client' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.client).must_be_instance_of Rubyists::Domeapi::Client
  end

  it 'sets prefix on initialization' do
    client = Rubyists::Domeapi::Client.new
    Rubyists::Domeapi::Polymarket::Client.new(client)

    _(client.prefix).must_equal 'polymarket'
  end

  it 'delegates get to the client' do
    mock_client = Object.new
    class << mock_client
      attr_accessor :prefix

      def get(path, params: {})
        { path: path, params: params }
      end
    end

    client = Rubyists::Domeapi::Polymarket::Client.new(mock_client)
    result = client.get('path')

    _(mock_client.prefix).must_equal 'polymarket'
    _(result).must_equal({ path: 'path', params: {} })
  end

  it 'initializes markets endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.markets).must_be_instance_of Rubyists::Domeapi::Polymarket::Markets
  end

  it 'initializes candlesticks endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.candlesticks).must_be_instance_of Rubyists::Domeapi::Polymarket::Candlesticks
  end

  it 'initializes trade_history endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.trade_history).must_be_instance_of Rubyists::Domeapi::Polymarket::TradeHistory
  end

  it 'initializes orderbook endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.orderbook).must_be_instance_of Rubyists::Domeapi::Polymarket::Orderbook
  end

  it 'initializes activity endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.activity).must_be_instance_of Rubyists::Domeapi::Polymarket::Activity
  end

  it 'initializes market_price endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.market_price).must_be_instance_of Rubyists::Domeapi::Polymarket::MarketPrice
  end

  it 'initializes wallet endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.wallet).must_be_instance_of Rubyists::Domeapi::Polymarket::Wallet
  end

  it 'initializes wallet_profit_and_loss endpoint' do
    client = Rubyists::Domeapi::Polymarket::Client.new

    _(client.wallet_profit_and_loss).must_be_instance_of Rubyists::Domeapi::Polymarket::WalletProfitAndLoss
  end
end
