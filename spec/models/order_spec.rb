require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should belong_to(:user)}
  it {should have_many(:placements)}

  describe '#set_total_price!' do
    before(:each) do
      product_1 = FactoryBot.create :product, price: 100.0
      product_2 = FactoryBot.create :product, price: 85.0

      @order = FactoryBot.create :order, product_ids: [product_1.id, product_2.id]
    end

    it "returns the total amount to pay for the products" do
      expect(@order.price).to eql 185.0
    end
  end
end
