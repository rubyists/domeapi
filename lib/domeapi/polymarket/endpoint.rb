# frozen_string_literal: true

module Rubyists
  module Domeapi
    module Polymarket
      # Base class for Polymarket API endpoints
      class Endpoint
        attr_reader :client

        # Initialize the Endpoint
        #
        # @param client [Client] The Domeapi client
        #
        # @return [void]
        def initialize(client = nil)
          @client = client || ::Rubyists::Domeapi::Client.new
        end
      end
    end
  end
end
