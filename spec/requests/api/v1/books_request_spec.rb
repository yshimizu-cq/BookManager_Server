require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  include JwtAuthenticator

  let(:user) { create(:user) }

  let(:book) { create(:book, user_id: user.id) }
  let(:new_book) { build(:book, user_id: user.id) }

  let(:headers_with_token) { { CONTENT_TYPE: "application/json", Authorization: encode(user.id) } }
  let(:headers_without_token) { { CONTENT_TYPE: "application/json" } }

  describe "GET /books" do
    it "response status 200" do
      get api_v1_books_path, headers: headers_with_token
      expect(response.status).to eq 200
    end
  end

####################### Imgur制限のため以下テスト未確認 #########################

  describe "POST /books" do
    subject { -> { post api_v1_books_path, params: params, headers: headers } }

    context "response success" do
      let(:params) { new_book.slice(:name, :image_url, :price, :purchase_date) }
      let(:headers) { headers_with_token }

      it "can resister book" do
        is_expected.to change(Book, :count).by(1)
        expect(JSON.parse(@response.body)["result"]).to be_present
      end
    end

    context "response error" do
      context "without token" do
        let(:params) { new_book.slice(:name, :image_url, :price, :purchase_date) }
        let(:headers) { headers_without_token }
    
        it "can't resister book" do
          is_expected.not_to change(Book, :count)
          expect(JSON.parse(@response.body)["error"]).to be_present
        end
      end
    end
  end

  describe "PATCH /books/:id" do
    it "response status 200" do
      expect do
        post api_v1_book_path(book.id),
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_with_token
      end.not_to change(Book, :count)
      expect(JSON.parse(@response.body)["result"]).to be_present
    end

    it "can't update book without token" do
      expect do
        post api_v1_book_path(book.id),
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_without_token
      end.not_to change(Book, :count)
      expect(JSON.parse(@response.body)["error"]).to be_present
    end
  end
end
