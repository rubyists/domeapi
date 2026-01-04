# frozen_string_literal: true

require 'helper'

module Rubyists
  class DomeapiTest < Minitest::Spec
    describe 'Domeapi' do
      subject { ::Rubyists::Domeapi }

      it 'has a version number' do
        refute_nil subject::VERSION
      end

      describe 'VERSION' do
        subject { ::Rubyists::Domeapi::VERSION }

        it 'is a valid semantic version' do
          semver_regex = /\A\d+\.\d+\.\d+(-[0-9A-Za-z\-.]+)?(\+[0-9A-Za-z\-.]+)?\z/

          assert_match(semver_regex, subject)
        end
      end
    end
  end
end
