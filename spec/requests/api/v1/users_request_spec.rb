require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  xdescribe "GET /sing_up" do
    it "returns http success" do
      get "/api/v1/users/sing_up"
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET /login" do
    it "returns http success" do
      get "/api/v1/users/login"
      expect(response).to have_http_status(:success)
    end
  end
end
