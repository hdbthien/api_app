require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

  it "password length less than 8 characters is invalid" do
    user = User.new(email: "foo@bar.com", password: "1234567", name: Faker::Name.name)

    result = user.save

    expect(result).to be(false)
  end

  it "password length must be atleast 8 characters" do
    user = User.new(email: "foo@bar.com", password: "12345678", name: Faker::Name.name)

    result = user.save

    expect(result).to be(true)
  end

  it "email must be unique" do
    user = User.new(email: "foo@bar.com", password: "12345678", name: Faker::Name.name)
    user.save

    u = User.new(email: "foo@bar.com", password: "12345671", name: Faker::Name.name)
    u.save

    expect(u.errors[:email]).to eq(["has already been taken"])
  end

  it "email with invalid format is invalid" do
    user = User.new(email: "bugs", password: "12345678", name: Faker::Name.name)
    user.save

    expect(user.errors[:email]).to eq(["is invalid"])
  end

  it "has no errors for valid email format" do
    user = User.new(email: "foo@bar.com", password: "12345678", name: Faker::Name.name)
    result = user.save

    expect(result).to be(true)
  end
end
