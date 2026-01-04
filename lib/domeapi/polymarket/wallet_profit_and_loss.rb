# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Wallet Profit and Loss API endpoints
      class WalletProfitAndLoss < Endpoint
        include Listable

        polymarket_path 'wallet/pnl'

        # Filter for wallet pnl
        class Filter < Contract
          Properties = Struct.new(
            :wallet_address,
            :granularity,
            :start_time,
            :end_time,
            keyword_init: true
          )

          Properties.members.each { |member| property member, populator: ->(value:, **) { value || skip! } }

          validation do
            params do
              required(:wallet_address).filled(:string)
              required(:granularity).filled(:string, included_in?: %w[day week month year all])
              optional(:start_time).maybe(:integer)
              optional(:end_time).maybe(:integer)
            end
          end
        end
      end
    end
  end
end
