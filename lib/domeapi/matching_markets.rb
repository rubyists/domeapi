# frozen_string_literal: true

module Rubyists
  module Domeapi
    # Matching Markets API endpoints
    class MatchingMarkets
      SPORTS = %w[nfl mlb cfb nba nhl cbb].freeze

      # Filter for matching markets sports
      class SportsFilter < Contract
        propertize(%i[sport date])

        validation do
          params do
            required(:sport).filled(:string, included_in?: SPORTS)
            required(:date).filled(:string, format?: /\A\d{4}-\d{2}-\d{2}\z/)
          end
        end
      end

      # Filter for matching markets
      class Filter < Contract
        propertize(%i[polymarket_market_slug kalshi_event_ticker])

        validation do
          params do
            optional(:polymarket_market_slug).maybe(Types::PolymarketMarketSlug)
            optional(:kalshi_event_ticker).maybe(Types::KalshiEventTicker)
          end

          rule(:polymarket_market_slug, :kalshi_event_ticker) do
            if !values[:polymarket_market_slug] && !values[:kalshi_event_ticker]
              key.failure('Either polymarket_market_slug or kalshi_event_ticker must be provided')
            end
          end
        end
      end

      attr_reader :client

      # @param client [Rubyists::Domeapi::Client]
      #
      # @return [void]
      def initialize(client = Rubyists::Domeapi::Client.new)
        @client = client
      end

      # List matching markets
      #
      # @param filter [Filter|Hash] Filter options
      #
      # @return [Hash|Array] resource data
      def sports(filter = Filter.new(Filter::Properties.new))
        filter = Filter.new(Filter::Properties.new(**filter)) if filter.is_a?(Hash)
        raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

        client.get('matching-markets/sports', params: filter.to_h)
      end

      # List matching markets for a specific sport and date
      #
      # @param filter [SportsFilter|Hash] Filter options
      #
      # @return [Hash|Array] resource data
      def sports_by_date(filter = SportsFilter.new(SportsFilter::Properties.new))
        filter = prepare_sports_filter(filter)
        raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

        client.get("matching-markets/sports/#{filter.sport}", params: { date: filter.date })
      end

      SPORTS.each do |sport|
        define_method("#{sport}_on") do |date|
          sports_by_date(sport: sport, date: date)
        end

        define_singleton_method("#{sport}_on") do |date|
          new.send("#{sport}_on", date)
        end
      end

      private

      def prepare_sports_filter(filter)
        return filter unless filter.is_a?(Hash)

        filter[:date] = filter[:date].strftime('%Y-%m-%d') if filter[:date].respond_to?(:strftime)
        SportsFilter.new(SportsFilter::Properties.new(**filter))
      end
    end
  end
end
