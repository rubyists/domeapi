# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:wallet) { client.polymarket.wallet }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Wallet' do
    it 'gets wallet with eoa' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/wallet')
        .with(query: { eoa: '0x123' })
        .to_return(status: 200, body: '{"eoa": "0x123"}')

      response = wallet.list(eoa: '0x123')

      _(response).must_equal({ eoa: '0x123' })
    end

    it 'gets wallet with proxy' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/wallet')
        .with(query: { proxy: '0x456' })
        .to_return(status: 200, body: '{"proxy": "0x456"}')

      response = wallet.list(proxy: '0x456')

      _(response).must_equal({ proxy: '0x456' })
    end

    it 'validates either eoa or proxy' do
      error = _ { wallet.list({}) }.must_raise ArgumentError
      _(error.message).must_include 'Either eoa or proxy must be provided'

      error = _ { wallet.list(eoa: '0x123', proxy: '0x456') }.must_raise ArgumentError
      _(error.message).must_include 'Either eoa or proxy must be provided, but not both'
    end
  end
end
