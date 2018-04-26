FactoryBot.define do
  factory :product do
    name {Faker::Commerce.product_name}
    price {Faker::Commerce.price}
    brand {Faker::Company.name}
  end
end
