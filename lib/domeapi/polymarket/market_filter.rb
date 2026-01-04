# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Filter for Polymarket markets
      class MarketFilter < Contract
        Properties = Struct.new(
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

        Properties.members.each { |member| property member, populator: ->(model:, **) { model || skip! } }

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
