require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:sign_up_user) { build(:user) }
  let(:invalid_user) { build(:user, :invalid) }
  let!(:login_user) { create(:user) }

  describe "POST /sign_up" do
    subject { -> { post api_v1_sign_up_path, params: params } }

    context "response success" do
      let(:params) { { email: sign_up_user.email, password: sign_up_user.password } }

      # spec_helperにaggregate_failures定義
      it "can sign up" do
        is_expected.to change(User, :count).by(1)
        expect(JSON.parse(@response.body)["result"]).to be_present # JSON形式でレスポンス
      end
    end

    context "response error" do
      context "with invalid email" do
        let(:params) { { email: invalid_user.email, password: sign_up_user.password } }

        it "can't sign up" do
          is_expected.not_to change(User, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end

      context "with duplidated email" do
        let(:params) { { email: login_user.email, password: sign_up_user.password } }

        it "can't sign up" do
          is_expected.not_to change(User, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end
    end
  end

  describe "POST /login" do
    context "response success" do
      let(:params) { { email: login_user.email, password: login_user.password } }

      it "can log in" do
        post api_v1_login_path, params: {
          email: login_user.email,
          password: login_user.password,
        }
        expect(JSON.parse(@response.body)["result"]).to be_present
      end
    end

    context "response error" do
      context "with invalid email" do
        let(:params) { { email: invalid_user.email, password: login_user.password } }

        it "can't log in" do
          post api_v1_login_path, params: {
            email: invalid_user.email,
            password: login_user.password,
          }
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end

      context "with wrong password" do
        let(:params) { { email: login_user.email, password: "wrong" } }

        it "can't log in" do
          post api_v1_login_path, params: {
            email: login_user.email,
            password: "wrong_password",
          }
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end
    end
  end
end
