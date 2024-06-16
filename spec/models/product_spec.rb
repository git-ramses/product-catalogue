require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is invalid without a name' do
      product = Product.new(name: nil, price: 50, description: 'some product')

      expect(product).not_to be_valid
    end

    it 'is invalid without a price' do
      product = Product.new(name: 'test product', price: nil, description: 'some product')

      expect(product).not_to be_valid
    end

    it 'is invalid with a price that is not a number' do
      product = Product.new(name: 'test product', price: 'not a number', description: 'some product')

      expect(product).not_to be_valid
    end

    it 'is invalid without a description' do
      product = Product.new(name: 'test product', price: 50, description: nil)

      expect(product).not_to be_valid
    end

    it 'is valid with valid attributes' do
      product = Product.new(name: 'test product', price: 50, description: 'some product')

      expect(product).to be_valid
    end
  end
end
