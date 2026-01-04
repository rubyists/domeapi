# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Markets API endpoints
      class Markets
        attr_reader :client

        # Filter for Polymarket markets,
        # from https://docs.domeapi.io/api-reference/endpoint/get-markets
        class Filter < Contract
          Properties = Struct.new(
            *custom_definitions,
            :market_slug,
            :event_slug,
            :condition_id,
            :tags,
            :status,
            :min_volume,
            :limit,
            :offset,
            :start_time,
            :end_time,
            keyword_init: true
          )

          # Define properties with custom populator to skip optional params with nil values
          (Properties.members - custom_definitions).each do |member|
            property member, populator: ->(value:, **) { value || skip! }
          end

          validation do
            params do
              optional(:status).maybe(:string, included_in?: %w[open closed])
              optional(:offset).maybe(:integer, gteq?: 0, lteq?: 100)
            end
          end
        end

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
        def list(filter = Filter.new(Filter::Properties.new))
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.valid?

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
      end
    end
  end
end
