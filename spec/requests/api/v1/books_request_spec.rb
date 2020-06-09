require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  include JwtAuthenticator

  let(:user) { create(:user) }

  let(:book) { create(:book, user_id: user.id) }
  let(:new_book) { build(:book, user_id: user.id) }

  let(:headers_with_token) { { CONTENT_TYPE: "application/json", Authorization: encode(user.id) } }
  let(:headers_without_token) { { CONTENT_TYPE: "application/json", Authorization: "" } }

  describe "GET /books" do
    it "response status 200" do
      get api_v1_books_path, headers: headers_with_token
      expect(response.status).to eq 200
    end
  end

  # imgur上限にかかったため以下テスト未確認 @2020/06/09

  describe "POST /books" do
    it "response status 200" do
      expect do
        post api_v1_books_path,
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_with_token
      end.to change(Book, :count).by(1)
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).not_to be_blank
    end

    it "can't create book without token" do
      expect do
        post api_v1_books_path,
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_without_token
      end.not_to change(Book, :count)
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).to be_blank
    end
  end

  describe "PATCH /books/:id" do
    it "response status 200" do
      expect do
        post api_v1_book_path(book.id),
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_with_token
      end.not_to change(Book, :count)
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).not_to be_blank
    end

    it "can't update book without token" do
      expect do
        post api_v1_book_path(book.id),
             params: new_book.slice(:name, :image_url, :price, :purchase_date),
             headers: headers_without_token
      end.not_to change(Book, :count)
      response_json = JSON.parse(@response.body)
      expect(response_json["result"]).to be_blank
    end
  end
end
