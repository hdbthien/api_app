FactoryBot.define do
  sequence(:email) { |n| "foo#{n}@bar.com" }
  factory :user do
    name {Faker::Name.name}
    email
    password "12345678"
    factory :admin do
      admin true
    end
  end
end
