User.create! name: "admin", email: "admin@api.com", password: "12345678", admin: true
user = User.create! name: "user", email: "user4@example.com", password: "12345678"

(1..10).each do |i|
  Product.create! name: Faker::Commerce.product_name, price: Faker::Commerce.price,
    brand: Faker::Company.name
end

(1..5).each do |i|
  offset = rand(Product.count)
  products = Product.offset(offset).take 2
  order_params = {price: products[0].price + products[1].price, user_id: user.id, product_ids: [products[0].id, products[1].id]}
  Order.create order_params
end
