# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:orderbook) { client.polymarket.orderbook }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Orderbook' do
    it 'gets orderbook history' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_orderbook_history')
        .with(query: { token_id: '123', start_time: '1000', end_time: '2000' })
        .to_return(status: 200, body: '{"snapshots": []}')

      filter = Rubyists::Domeapi::Polymarket::Orderbook::Filter.new(
        Rubyists::Domeapi::Polymarket::Orderbook::Filter::Properties.new(
          token_id: '123',
          start_time: 1000,
          end_time: 2000
        )
      )
      response = orderbook.list(filter)

      _(response).must_equal({ snapshots: [] })
    end

    it 'validates required parameters' do
      filter = Rubyists::Domeapi::Polymarket::Orderbook::Filter.new(
        Rubyists::Domeapi::Polymarket::Orderbook::Filter::Properties.new
      )

      error = _ { orderbook.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Token Id must be filled'
      _(error.message).must_include 'Start Time must be filled'
      _(error.message).must_include 'End Time must be filled'
    end

    it 'validates limit range' do
      filter = Rubyists::Domeapi::Polymarket::Orderbook::Filter.new(
        Rubyists::Domeapi::Polymarket::Orderbook::Filter::Properties.new(
          token_id: '123',
          start_time: 1000,
          end_time: 2000,
          limit: 1001
        )
      )

      error = _ { orderbook.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Limit must be less than or equal to 1000'
    end
  end
end
