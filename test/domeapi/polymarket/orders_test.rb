# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:orders) { client.polymarket.orders }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Orders' do
    it 'gets orders' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/orders/get_orders')
        .with(query: { market_slug: 'slug', limit: '10' })
        .to_return(status: 200, body: '[]')

      response = orders.list(market_slug: 'slug', limit: 10)

      _(response).must_equal([])
    end
  end
end
