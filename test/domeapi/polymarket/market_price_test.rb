# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:market_price) { client.polymarket.market_price }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Market Price' do
    it 'gets market price' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_market_price')
        .with(query: { token_id: '123' })
        .to_return(status: 200, body: '{"price": 0.5}')

      response = market_price.list(token_id: '123')

      _(response).must_equal({ price: 0.5 })
    end

    it 'validates required parameters' do
      error = _ { market_price.list({}) }.must_raise ArgumentError
      _(error.message).must_include 'Token Id must be filled'
    end
  end
end
