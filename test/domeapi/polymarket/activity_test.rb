# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:activity) { client.polymarket.activity }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Activity' do
    it 'gets activity' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/activity')
        .with(query: { user: '0x123' })
        .to_return(status: 200, body: '{"activities": []}')

      response = activity.list(user: '0x123')

      _(response).must_equal({ activities: [] })
    end

    it 'validates required parameters' do
      error = _ { activity.list({}) }.must_raise ArgumentError
      _(error.message).must_include 'User must be filled'
    end
  end
end
