# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:wallet_pnl) { client.polymarket.wallet_profit_and_loss }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Wallet Profit and Loss' do
    it 'gets wallet pnl' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/wallet/pnl')
        .with(query: { wallet_address: '0x123', granularity: 'day' })
        .to_return(status: 200, body: '{"pnl_over_time": []}')

      response = wallet_pnl.list(wallet_address: '0x123', granularity: 'day')

      _(response).must_equal({ pnl_over_time: [] })
    end

    it 'validates required parameters' do
      error = _ { wallet_pnl.list({}) }.must_raise ArgumentError
      _(error.message).must_include 'Wallet Address must be filled'
      _(error.message).must_include 'Granularity must be filled'
    end

    it 'validates granularity' do
      error = _ { wallet_pnl.list(wallet_address: '0x123', granularity: 'invalid') }.must_raise ArgumentError
      _(error.message).must_include 'Granularity must be one of: day, week, month, year, all'
    end
  end
end
