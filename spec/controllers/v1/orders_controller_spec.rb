require 'rails_helper'

describe Api::V1::OrdersController do
  let!(:user) {create(:user)}
  let(:headers) {{"Authorization" => token_generator(user.id)}}

  describe "GET api/v1/orders#index" do
    before(:each) do
      4.times {FactoryBot.create :order, user: user}
      request.headers.merge headers
      get :index
    end

    it "returns 4 order records from the user" do
      expect(json.size).to eq 4
    end

    it {should respond_with 200}
  end

  describe "GET api/v1/orders#show" do
    before(:each) do
      @order = FactoryBot.create :order, user: user
      request.headers.merge headers
      get :show, params: {id: @order.id}, format: :json
    end

    it "returns the user order record matching the id" do
      expect(json["id"]).to eql @order.id
    end

    it {should respond_with 200}
  end

  describe "POST api/v1/orders#create" do
    before(:each) do
      product_1 = FactoryBot.create :product
      product_2 = FactoryBot.create :product
      order_params = {product_ids: [product_1.id, product_2.id]}
      request.headers.merge headers
      post :create, params: {order: order_params}, format: :json
    end

    it "returns the just user order record" do
      expect(json["id"]).to be_present
    end

    it {should respond_with 201}
  end

end
