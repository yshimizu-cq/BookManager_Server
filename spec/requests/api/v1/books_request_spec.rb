require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  include JwtAuthenticator

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:book) { create(:book, user_id: user.id) }
  let(:new_book) { build(:book, user_id: user.id) }
  let(:other_book) { create(:book, user_id: other_user.id) }

  let(:headers_with_token) { { CONTENT_TYPE: "application/json", Authorization: encode(user.id) } }
  let(:headers_without_token) { { CONTENT_TYPE: "application/json" } }

  describe "GET /books" do
    subject { get api_v1_books_path, headers: headers_with_token }

    it { is_expected.to eq 200 }
  end

  # Imgur制限のため以下テスト未確認
  describe "POST /books" do
    subject { -> { post api_v1_books_path, params: params, headers: headers } }

    context "response success" do
      let(:params) { attributes_for(:new_book) }
      let(:headers) { headers_with_token }

      it "can resister book" do
        is_expected.to change(Book, :count).by(1)
        expect(JSON.parse(@response.body)["result"]).to be_present
      end
    end

    context "response error" do
      context "without token" do
        let(:params) { attributes_for(:new_book) }
        let(:headers) { headers_without_token }

        it "can't resister book" do
          is_expected.not_to change(Book, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end

      context "without book name" do
        let(:params) { attributes_for(:new_book) }
        let(:headers) { headers_with_token }

        it "can't resister book" do
          is_expected.not_to change(Book, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end
    end
  end

  describe "PATCH /books/:id" do
    context "response success" do
      it "response status 200" do
        expect do
          post api_v1_book_path(book.id),
               params: attributes_for(:new_book),
               headers: headers_with_token
        end.not_to change(Book, :count)
        expect(JSON.parse(@response.body)["result"]).to be_present
      end
    end

    context "response error" do
      context "without token" do
        it "can't update" do
          expect do
            post api_v1_book_path(book.id),
                 params: attributes_for(:new_book),
                 headers: headers_without_token
          end.not_to change(Book, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end

      context "when book is not related to current_user" do
        it "can't update" do
          expect do
            post api_v1_book_path(other_book.id),
                 params: attributes_for(:new_book),
                 headers: headers_with_token
          end.not_to change(Book, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end
    end
  end
end
