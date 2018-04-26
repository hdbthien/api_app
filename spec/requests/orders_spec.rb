RSpec.describe "Orders", type: :request do
  let!(:user) {create(:user)}
  let(:headers) {{"Authorization" => token_generator(user.id)}}

  it "works! (now write some real specs)" do
    get api_v1_orders_path, headers: headers
    expect(response).to have_http_status(200)
  end
end
