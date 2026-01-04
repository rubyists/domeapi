# frozen_string_literal: true

require 'httpx'
require 'json'

module Rubyists
  module Domeapi
    # HTTP Client for Domeapi API
    class Client
      include SemanticLogger::Loggable

      attr_reader :http, :base_url
      attr_accessor :prefix

      def initialize(api_key: Domeapi.config.api_key, base_url: Domeapi.config.base_url)
        @base_url = base_url
        @http = HTTPX.plugin(:persistent)
                     .plugin(:rate_limiter)
                     .with(origin: base_url, headers: { 'Authorization' => "Bearer #{api_key}" })
      end

      def get(path, params: {})
        response = @http.get(full_url(path), params:)
        handle_response(response)
      end

      def polymarket
        @polymarket ||= Polymarket::Client.new(self)
      end

      private

      def full_url(path)
        File.join(*[base_url, prefix, path].compact)
      end

      def handle_response(response)
        response.raise_for_status
        JSON.parse(response.body.to_s, symbolize_names: true)
      rescue HTTPX::HTTPError => e
        logger.error('API Error', e)
        raise Error, "API Error: #{e.response.status} - #{e.response.body}"
      end
    end
  end
end
