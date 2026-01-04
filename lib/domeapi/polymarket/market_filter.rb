# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Filter for Polymarket markets
      class MarketFilter < Contract
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
    end
  end
end
