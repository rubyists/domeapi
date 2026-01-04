# frozen_string_literal: true

require 'reform'
require 'reform/form/dry'

module Rubyists
  module Domeapi
    # Base Contract class for Trailblazer/Reform forms
    class Contract < Reform::Form
      feature Reform::Form::Dry

      # Custom class methods can be defined here
      module ClassMethods
        def propertize(*names)
          # names is always an array because of the splat
          names = names.flatten
          const_set(:Properties, Struct.new(*custom_definitions, *names, keyword_init: true))
          names.each { |name| property name, populator: ->(value:, **) { value || skip! } }
        end
      end

      def self.inherited(subclass)
        subclass.extend ClassMethods
        super
      end

      def self.custom_definitions = instance_variable_get(:@definitions)&.keys&.map(&:to_sym) || []

      def to_h
        to_nested_hash.compact
      end
    end
  end
end
