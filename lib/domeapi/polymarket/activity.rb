# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Activity API endpoints
      class Activity < Endpoint
        include Listable

        polymarket_path 'activity'

        # Filter for activity
        class Filter < Contract
          propertize(%i[user start_time end_time market_slug condition_id limit offset])

          validation do
            params do
              required(:user).filled(:string)
              optional(:start_time).maybe(:integer)
              optional(:end_time).maybe(:integer)
              optional(:market_slug).maybe(:string)
              optional(:condition_id).maybe(:string)
              optional(:limit).maybe(:integer, gteq?: 1, lteq?: 1000)
              optional(:offset).maybe(:integer, gteq?: 0)
            end
          end
        end
      end
    end
  end
end
