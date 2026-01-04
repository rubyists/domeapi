# frozen_string_literal: true

require_relative '../lib/domeapi'

require 'minitest/autorun'
require 'webmock/minitest'
require 'httpx'
require 'httpx/adapters/webmock'
WebMock::HttpLibAdapters::HttpxAdapter.enable!

WebMock.disable_net_connect!(allow_localhost: true)

module Minitest
  class Spec
    before do
      Rubyists::Domeapi.configure do |config|
        config.api_key = 'test_api_key'
      end
    end
  end
end
