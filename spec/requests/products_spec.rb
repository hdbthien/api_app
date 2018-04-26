RSpec.describe "Products", type: :request do
  let!(:user) {create(:user)}
  let(:headers) {{"Authorization" => token_generator(user.id)}}

  describe "GET api/v1/products" do
    it "works! (now write some real specs)" do
      get api_v1_products_path, headers: headers
      expect(response).to have_http_status(200)
    end
  end
end
