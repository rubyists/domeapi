# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Markets API endpoints
      class Markets
        attr_reader :client

        class << self
          # @see #list
          def list(...)
            new.list(...)
          end
        end

        # @param client [Rubyists::Domeapi::Polymarket::Client]
        #
        # @return [void]
        def initialize(client = Rubyists::Domeapi::Polymarket::Client.new)
          @client = client
        end

        # List markets
        # @param filter [MarketFilter] Filter options
        #
        # @return [Array<Polymarket::Market>] list of markets
        def list(filter = MarketFilter.new(MarketFilter::Properties.new))
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

          client.get('markets', params: filter.to_h)
        end

        # Fetch current or historical price for a market
        #
        # @param token_id [String]
        # @param at_time [Integer] optional timestamp
        #
        # @return [Hash] market price data
        def price(token_id:, at_time: nil)
          params = { token_id: token_id }
          params[:at_time] = at_time if at_time
          client.get('markets/get_market_price', params: params)
        end

        # Get OHLC candlesticks
        #
        # @param condition_id [String]
        # @param start_time [Integer]
        # @param end_time [Integer]
        # @param interval [Integer]
        #
        # @return [Hash] candlestick data
        def candlesticks(condition_id:, start_time:, end_time:, interval:)
          params = {
            condition_id: condition_id,
            start_time: start_time,
            end_time: end_time,
            interval: interval
          }
          client.get('markets/get_candlesticks', params: params)
        end
      end
    end
  end
end
