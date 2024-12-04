require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    let(:category) { Category.create(name: 'Electronics') }  # Create a category for testing
    let(:valid_product) { Product.new(name: 'Test Product', price: 100.0, quantity: 10, category: category) }

    it 'is valid with all required fields' do
      expect(valid_product).to be_valid
    end

    it 'is invalid without a name' do
      valid_product.name = nil
      expect(valid_product).to_not be_valid
      expect(valid_product.errors.full_messages).to include("Name can't be blank")
    end

    it 'is invalid without a price' do
      valid_product.price_cents = nil
      expect(valid_product).to_not be_valid
      expect(valid_product.errors.full_messages).to include("Price can't be blank")
    end

    it 'is invalid without a quantity' do
      valid_product.quantity = nil
      expect(valid_product).to_not be_valid
      expect(valid_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'is invalid without a category' do
      valid_product.category = nil
      expect(valid_product).to_not be_valid
      expect(valid_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
