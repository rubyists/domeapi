# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:trade_history) { client.polymarket.trade_history }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Trade History' do
    it 'gets trade history' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_trade_history')
        .with(query: { market_slug: 'slug', limit: '10' })
        .to_return(status: 200, body: '{"trades": []}')

      filter = Rubyists::Domeapi::Polymarket::TradeHistory::Filter.new(
        Rubyists::Domeapi::Polymarket::TradeHistory::Filter::Properties.new(
          market_slug: 'slug',
          limit: 10
        )
      )
      response = trade_history.list(filter)

      _(response).must_equal({ trades: [] })
    end

    it 'validates limit range' do
      filter = Rubyists::Domeapi::Polymarket::TradeHistory::Filter.new(
        Rubyists::Domeapi::Polymarket::TradeHistory::Filter::Properties.new(limit: 1001)
      )

      error = _ { trade_history.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Limit must be less than or equal to 1000'

      filter = Rubyists::Domeapi::Polymarket::TradeHistory::Filter.new(
        Rubyists::Domeapi::Polymarket::TradeHistory::Filter::Properties.new(limit: 0)
      )

      error = _ { trade_history.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Limit must be greater than or equal to 1'
    end

    it 'validates offset range' do
      filter = Rubyists::Domeapi::Polymarket::TradeHistory::Filter.new(
        Rubyists::Domeapi::Polymarket::TradeHistory::Filter::Properties.new(offset: -1)
      )

      error = _ { trade_history.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Offset must be greater than or equal to 0'
    end
  end
end
