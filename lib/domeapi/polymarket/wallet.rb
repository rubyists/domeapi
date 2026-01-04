# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Wallet API endpoints
      class Wallet < Endpoint
        include Listable

        polymarket_path 'wallet'

        # Filter for wallet
        class Filter < Contract
          propertize(%i[eoa proxy with_metrics start_time end_time])

          validation do
            # :nocov:
            params do
              optional(:eoa).maybe(:string)
              optional(:proxy).maybe(:string)
              optional(:with_metrics).maybe(:bool)
              optional(:start_time).maybe(:integer)
              optional(:end_time).maybe(:integer)
            end

            rule(:eoa, :proxy) do
              key.failure('Either eoa or proxy must be provided, but not both') if values[:eoa] && values[:proxy]
              key.failure('Either eoa or proxy must be provided') if !values[:eoa] && !values[:proxy]
            end
            # :nocov:
          end
        end
      end
    end
  end
end
