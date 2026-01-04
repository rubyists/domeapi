# frozen_string_literal: true

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-json'
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::JSONFormatter
    ]
  )
  SimpleCov.start do
    enable_coverage :branch
    add_filter '/test/'
    add_filter '/vendor/'
  end
end

require_relative '../lib/domeapi'

require 'minitest/autorun'
require 'minitest/spec'
require 'shoulda/context'
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
