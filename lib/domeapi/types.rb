# frozen_string_literal: true

require 'dry-types'

module Rubyists
  module Domeapi
    # Custom types for Domeapi
    module Types
      include Dry.Types()

      # Polymarket slugs are typically kebab-case strings
      PolymarketMarketSlug = String.constrained(format: /\A[a-z0-9]+(?:-[a-z0-9]+)+\z/)

      # Kalshi event tickers are typically uppercase alphanumeric strings, potentially with dashes
      KalshiEventTicker = String.constrained(format: /\A[A-Z0-9]+(?:-[A-Z0-9]+)+\z/)
    end
  end
end
