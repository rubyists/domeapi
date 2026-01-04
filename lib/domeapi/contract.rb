# frozen_string_literal: true

require 'reform'
require 'reform/form/dry'

module Rubyists
  module Domeapi
    # Base Contract class for Trailblazer/Reform forms
    class Contract < Reform::Form
      feature Reform::Form::Dry

      def to_h
        to_nested_hash.compact
      end
    end
  end
end
