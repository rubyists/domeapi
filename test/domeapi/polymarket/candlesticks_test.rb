# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Client do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:candlesticks) { client.polymarket.candlesticks }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Polymarket Candlesticks' do
    it 'gets candlesticks with interval' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_candlesticks')
        .with(query: { condition_id: 'abc', start_time: '100', end_time: '200', interval: '60' })
        .to_return(status: 200, body: '{"candlesticks": []}')

      filter = Rubyists::Domeapi::Polymarket::Candlesticks::Filter.new(
        Rubyists::Domeapi::Polymarket::Candlesticks::Filter::Properties.new(
          condition_id: 'abc',
          start_time: 100,
          end_time: 200,
          interval: 60
        )
      )
      response = candlesticks.list(filter)

      _(response).must_equal({ candlesticks: [] })
    end

    it 'gets candlesticks without interval' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets/get_candlesticks')
        .with(query: { condition_id: 'abc', start_time: '100', end_time: '200' })
        .to_return(status: 200, body: '{"candlesticks": []}')

      filter = Rubyists::Domeapi::Polymarket::Candlesticks::Filter.new(
        Rubyists::Domeapi::Polymarket::Candlesticks::Filter::Properties.new(
          condition_id: 'abc',
          start_time: 100,
          end_time: 200
        )
      )
      response = candlesticks.list(filter)

      _(response).must_equal({ candlesticks: [] })
    end

    it 'validates required parameters' do
      filter = Rubyists::Domeapi::Polymarket::Candlesticks::Filter.new(
        Rubyists::Domeapi::Polymarket::Candlesticks::Filter::Properties.new
      )

      error = _ { candlesticks.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Condition Id must be filled'
      _(error.message).must_include 'Start Time must be filled'
      _(error.message).must_include 'End Time must be filled'
    end

    it 'validates interval range' do
      filter = Rubyists::Domeapi::Polymarket::Candlesticks::Filter.new(
        Rubyists::Domeapi::Polymarket::Candlesticks::Filter::Properties.new(
          condition_id: 'abc',
          start_time: 100,
          end_time: 200,
          interval: 1441
        )
      )

      error = _ { candlesticks.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Interval must be less than or equal to 1440'

      filter = Rubyists::Domeapi::Polymarket::Candlesticks::Filter.new(
        Rubyists::Domeapi::Polymarket::Candlesticks::Filter::Properties.new(
          condition_id: 'abc',
          start_time: 100,
          end_time: 200,
          interval: 0
        )
      )

      error = _ { candlesticks.list(filter) }.must_raise ArgumentError
      _(error.message).must_include 'Interval must be greater than or equal to 1'
    end
  end
end
