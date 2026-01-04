# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Polymarket::Endpoint do
  it 'initializes with default client' do
    endpoint = Rubyists::Domeapi::Polymarket::Endpoint.new

    _(endpoint.client).must_be_instance_of Rubyists::Domeapi::Client
  end

  it 'initializes with provided client' do
    client = Object.new
    endpoint = Rubyists::Domeapi::Polymarket::Endpoint.new(client)

    _(endpoint.client).must_equal client
  end
end
