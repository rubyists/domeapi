# frozen_string_literal: true

require_relative '../helper'

describe Rubyists::Domeapi::Contract do
  describe '.propertize' do
    class TestContract < Rubyists::Domeapi::Contract # rubocop:disable Lint/ConstantDefinitionInBlock
      propertize %i[foo bar]
    end

    it 'defines a Properties struct' do
      assert TestContract.const_defined?(:Properties)
      _(TestContract::Properties.members).must_equal %i[foo bar]
    end

    it 'accepts splat arguments' do
      klass = Class.new(Rubyists::Domeapi::Contract) do
        propertize :foo, :bar
      end

      _(klass::Properties.members).must_equal %i[foo bar]
    end

    it 'uses keyword_init for the struct' do
      _(TestContract::Properties.new(foo: 'bar').foo).must_equal 'bar'
      assert_raises(ArgumentError) { TestContract::Properties.new('bar', 'baz') }
    end

    it 'defines properties on the contract' do
      contract = TestContract.new(TestContract::Properties.new(foo: 'baz'))

      _(contract.foo).must_equal 'baz'
    end

    it 'skips nil values' do
      contract = TestContract.new(TestContract::Properties.new(foo: 'baz', bar: nil))
      contract.validate({})

      _(contract.to_h).must_equal({ 'foo' => 'baz' })
    end

    it 'includes existing definitions' do
      klass = Class.new(Rubyists::Domeapi::Contract) do
        property :existing
        propertize :new_prop
      end

      _(klass::Properties.members).must_include :existing
      _(klass::Properties.members).must_include :new_prop
    end
  end
end
