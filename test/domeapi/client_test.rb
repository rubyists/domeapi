# frozen_string_literal: true

require_relative '../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  it 'handles API errors' do
    stub_request(:get, 'https://api.domeapi.io/v1/error')
      .to_return(status: 500, body: 'Internal Server Error')

    error = _ { client.get('error') }.must_raise Rubyists::Domeapi::Error
    _(error.message).must_include 'API Error: 500'
    _(error.message).must_include 'Internal Server Error'
  end

  it 'constructs full url correctly' do
    client.prefix = 'test'
    # We can't easily test private methods, but we can test the effect via get
    stub_request(:get, 'https://api.domeapi.io/v1/test/path')
      .to_return(status: 200, body: '{}')

    client.get('path')
  end

  it 'returns a polymarket client' do
    _(client.polymarket).must_be_instance_of Rubyists::Domeapi::Polymarket::Client
  end

  it 'returns a matching_markets client' do
    _(client.matching_markets).must_be_instance_of Rubyists::Domeapi::MatchingMarkets
  end
end
