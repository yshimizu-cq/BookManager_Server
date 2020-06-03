require 'rails_helper'

RSpec.describe "Api::Vi::Users", type: :request do

  describe "GET /sing_up" do
    it "returns http success" do
      get "/api/vi/users/sing_up"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /login" do
    it "returns http success" do
      get "/api/vi/users/login"
      expect(response).to have_http_status(:success)
    end
  end

end
