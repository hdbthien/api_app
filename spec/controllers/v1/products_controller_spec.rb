require "rails_helper"

describe Api::V1::ProductsController do
  let!(:user) {create(:user)}
  let!(:admin) {create(:admin)}
  let(:admin_headers) {{"Authorization" => token_generator(admin.id)}}
  let(:not_admin_headers) {{"Authorization" => token_generator(user.id)}}

  describe "GET api/v1/products#index" do
    before(:each) do
      10.times {FactoryBot.create :product}
      request.headers.merge not_admin_headers
      get :index
    end

    it "returns 4 product records from the user" do
      expect(json.size).to eq 10
    end

    it {should respond_with 200}
  end

  describe "GET api/v1/products#show" do
    before(:each) do
      @product = FactoryBot.create :product
      request.headers.merge not_admin_headers
      get :show, params: {id: @product.id}, format: :json
    end

    it "returns the user product record matching the id" do
      expect(json["id"]).to eql @product.id
    end

    it {should respond_with 200}
  end

  describe "POST api/v1/products#create" do
    context "create successfully" do

      before(:each) do
        product_params = {name: Faker::Commerce.product_name, price: Faker::Commerce.price,
          brand: Faker::Company.name}
        request.headers.merge admin_headers
        post :create, params: {product: product_params}, format: :json
      end

      it "returns the just user product record" do
        expect(json["id"]).to be_present
      end

      it {should respond_with 201}
    end

    context "dont have permission" do
      before(:each) do
        product_params = {name: Faker::Commerce.product_name, price: Faker::Commerce.price,
          brand: Faker::Company.name}
        request.headers.merge not_admin_headers
        post :create, params: {product: product_params}, format: :json
      end

      it "does not upgrade user" do
        expect(response).to have_http_status(403)
      end

      it "returns failure message" do
        expect(json["message"])
          .to match(
            /Sorry, you dont have permission to do that. Please contact admin/)
      end
    end
  end

  describe "PATCH api/v1/products#update" do
    let!(:product){create(:product)}
    context "update successfully" do

      before(:each) do
        product_params = {name: Faker::Commerce.product_name, price: Faker::Commerce.price,
          brand: Faker::Company.name}
        request.headers.merge admin_headers
        patch :update, params: {product: product_params, id: product.id}, format: :json
      end

      it "returns the just user product record" do
        expect(json["id"]).to be_present
      end

      it {should respond_with 204}
    end

    context "dont have permission" do
      before(:each) do
        product_params = {name: Faker::Commerce.product_name, price: Faker::Commerce.price,
          brand: Faker::Company.name}
        request.headers.merge not_admin_headers
        patch :update, params: {product: product_params, id: product.id}, format: :json
      end

      it "does not upgrade user" do
        expect(response).to have_http_status(403)
      end

      it "returns failure message" do
        expect(json["message"])
          .to match(
            /Sorry, you dont have permission to do that. Please contact admin/)
      end
    end
  end

end
