# frozen_string_literal: true

require_relative '../helper'

describe Rubyists::Domeapi::MatchingMarkets do
  let(:client) { Rubyists::Domeapi::Client.new }
  let(:matching_markets) { client.matching_markets }

  before do
    Rubyists::Domeapi.configure do |config|
      config.api_key = 'test_api_key'
    end
  end

  describe 'Sports' do
    it 'lists matching markets for sports' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports')
        .with(query: { polymarket_market_slug: 'valid-slug' })
        .to_return(status: 200, body: '[]')

      response = matching_markets.sports(polymarket_market_slug: 'valid-slug')

      _(response).must_equal []
    end

    it 'lists matching markets for sports with Filter object' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports')
        .with(query: { polymarket_market_slug: 'valid-slug' })
        .to_return(status: 200, body: '[]')

      filter = Rubyists::Domeapi::MatchingMarkets::Filter.new(
        Rubyists::Domeapi::MatchingMarkets::Filter::Properties.new(polymarket_market_slug: 'valid-slug')
      )
      response = matching_markets.sports(filter)

      _(response).must_equal []
    end

    it 'validates filter' do
      error = _ { matching_markets.sports({}) }.must_raise ArgumentError
      _(error.message).must_include 'Either polymarket_market_slug or kalshi_event_ticker must be provided'
    end
  end

  describe 'Sports by Date' do
    it 'lists matching markets for sport and date' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports/nfl')
        .with(query: { date: '2023-01-01' })
        .to_return(status: 200, body: '[]')

      response = matching_markets.sports_by_date(sport: 'nfl', date: '2023-01-01')

      _(response).must_equal []
    end

    it 'accepts Date object' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports/nfl')
        .with(query: { date: '2023-01-01' })
        .to_return(status: 200, body: '[]')

      require 'date'
      response = matching_markets.sports_by_date(sport: 'nfl', date: Date.parse('2023-01-01'))

      _(response).must_equal []
    end

    it 'accepts SportsFilter object' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports/nfl')
        .with(query: { date: '2023-01-01' })
        .to_return(status: 200, body: '[]')

      filter = Rubyists::Domeapi::MatchingMarkets::SportsFilter.new(
        Rubyists::Domeapi::MatchingMarkets::SportsFilter::Properties.new(sport: 'nfl', date: '2023-01-01')
      )
      response = matching_markets.sports_by_date(filter)

      _(response).must_equal []
    end

    it 'validates sport' do
      error = _ { matching_markets.sports_by_date(sport: 'invalid', date: '2023-01-01') }.must_raise ArgumentError
      _(error.message).must_include 'Sport must be one of: nfl, mlb, cfb, nba, nhl, cbb'
    end

    it 'validates date format' do
      error = _ { matching_markets.sports_by_date(sport: 'nfl', date: 'invalid') }.must_raise ArgumentError
      _(error.message).must_include 'Date is in invalid format'
    end
  end

  describe 'Dynamic methods' do
    it 'defines methods for each sport' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports/nfl')
        .with(query: { date: '2023-01-01' })
        .to_return(status: 200, body: '[]')

      response = matching_markets.nfl_on('2023-01-01')

      _(response).must_equal []
    end

    it 'defines class methods for each sport' do
      stub_request(:get, 'https://api.domeapi.io/v1/matching-markets/sports/nfl')
        .with(query: { date: '2023-01-01' })
        .to_return(status: 200, body: '[]')

      response = Rubyists::Domeapi::MatchingMarkets.nfl_on('2023-01-01')

      _(response).must_equal []
    end
  end
end
