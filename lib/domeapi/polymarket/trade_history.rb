# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Trade History API endpoints
      class TradeHistory
        attr_reader :client

        # @param client [Rubyists::Domeapi::Polymarket::Client]
        #
        # @return [void]
        def initialize(client = Rubyists::Domeapi::Polymarket::Client.new)
          @client = client
        end

        # Filter for trade history
        class Filter < Contract
          Properties = Struct.new(
            :market_slug,
            :condition_id,
            :token_id,
            :start_time,
            :end_time,
            :limit,
            :offset,
            :user,
            keyword_init: true
          )

          Properties.members.each { |member| property member, populator: ->(model:, **) { model || skip! } }

          validation do
            params do
              optional(:market_slug).maybe(:string)
              optional(:condition_id).maybe(:string)
              optional(:token_id).maybe(:string)
              optional(:start_time).maybe(:integer)
              optional(:end_time).maybe(:integer)
              optional(:limit).maybe(:integer, gteq?: 1, lteq?: 1000)
              optional(:offset).maybe(:integer, gteq?: 0)
              optional(:user).maybe(:string)
            end
          end
        end

        # Get trade history
        #
        # @param filter [Filter] Filter options
        #
        # @return [Hash] trade history data
        def list(filter = Filter.new(Filter::Properties.new))
          raise ArgumentError, filter.errors.full_messages.join(', ') unless filter.validate({})

          client.get('markets/get_trade_history', params: filter.to_h)
        end
      end
    end
  end
end
