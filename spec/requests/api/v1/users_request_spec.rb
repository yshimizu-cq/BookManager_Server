require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:sing_up_user) { build(:user) }
  let(:invalid_user) { build(:user, :invalid) }
  let(:login_user) { create(:user) }

  describe "POST /sing_up" do
    it "response status 200" do
      expect do
        post api_v1_sign_up_path, params: {
          email: sing_up_user.email,
          password: sing_up_user.password,
        }
      end.to change(User, :count).by(1)
      response_json = JSON.parse(@response.body) # JSON形式でレスポンス
      expect(response_json["result"]).not_to be_blank
    end

    it "can't sign up with invalid email" do
      expect do
        post api_v1_sign_up_path, params: {
          email: invalid_user.email,
          password: invalid_user.password,
        }
      end.not_to change(User, :count)
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).to be_blank
    end
  end

  describe "POST /login" do
    it "response status 200" do
      post api_v1_login_path, params: {
        email: login_user.email,
        password: login_user.password,
      }
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).not_to be_blank
    end

    it "can't login with invalid email" do
      post api_v1_login_path, params: {
        email: invalid_user.email,
        password: invalid_user.password,
      }
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).to be_blank
    end
  end
end
