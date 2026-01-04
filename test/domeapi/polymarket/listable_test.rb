# frozen_string_literal: true

require_relative '../../helper'

describe Rubyists::Domeapi::Polymarket::Listable do
  # Test using Markets as it includes Listable
  describe 'Class methods' do
    it 'delegates list to instance' do
      stub_request(:get, 'https://api.domeapi.io/v1/polymarket/markets')
        .to_return(status: 200, body: '[]')

      response = Rubyists::Domeapi::Polymarket::Markets.list

      _(response).must_equal []
    end
  end
end
