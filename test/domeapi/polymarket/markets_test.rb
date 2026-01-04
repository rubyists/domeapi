# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:base_url) { 'https://api.domeapi.io/v1' }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  it 'initializes with config' do
    _(client.base_url).must_equal base_url
  end

  describe 'Polymarket Markets' do
    let(:markets) { client.polymarket.markets }

    it 'gets market price' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_market_price')
        .with(query: { token_id: '123' })
        .to_return(status: 200, body: '{"price": 0.5}')

      response = markets.price(token_id: '123')

      _(response).must_equal({ price: 0.5 })
    end

    it 'gets candlesticks' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_candlesticks')
        .with(query: { condition_id: 'abc', start_time: '100', end_time: '200', interval: '60' })
        .to_return(status: 200, body: '{"candlesticks": []}')

      response = markets.candlesticks(condition_id: 'abc', start_time: 100, end_time: 200, interval: 60)

      _(response).must_equal({ candlesticks: [] })
    end

    it 'lists markets' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets')
        .with(query: { limit: '10', offset: '0' })
        .to_return(status: 200, body: '[{"id": "market1"}]')

      filter = Rubyists::Domeapi::Polymarket::MarketFilter.new(
        Rubyists::Domeapi::Polymarket::MarketFilter::Properties.new(limit: 10, offset: 0)
      )
      response = markets.list(filter)

      _(response).must_equal([{ id: 'market1' }])
    end

    it 'lists markets with default filter' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets')
        .to_return(status: 200, body: '[{"id": "market1"}]')

      response = markets.list

      _(response).must_equal([{ id: 'market1' }])
    end
  end
end
