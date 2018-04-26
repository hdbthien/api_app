RSpec.describe "upgrade user to admin", type: :request do
  let(:admin) {create(:admin)}
  let(:user2) {create(:user)}
  let(:headers) {{"Authorization" => token_generator(admin.id)}}

  describe "PATCH /api/upgrade_user" do
    context "when valid request" do
      before {patch "/api/upgrade_user", params: {email: user2.email}, headers: headers}

      it "upgrade user to admin successfully" do
        expect(response).to have_http_status 200
      end

      it "returns success message" do
        expect(json["message"]).to match(/This user has been successfully upgraded/)
      end
    end

    context "email not found" do
      before {patch "/api/upgrade_user", params: {email: Faker::Internet.email}, headers: headers}

      it "does not upgrade user" do
        expect(response).to have_http_status(404)
      end

      it "returns failure message" do
        expect(json["message"])
          .to match(
            /Sorry, email not found/)
      end
    end

    context "when invalid request" do
      before {patch "/api/upgrade_user", params: {}, headers: headers}

      it "does not upgrade user" do
        expect(response).to have_http_status(404)
      end

      it "returns failure message" do
        expect(json["message"])
          .to match(
            /Sorry, email not found/)
      end
    end
  end
end
