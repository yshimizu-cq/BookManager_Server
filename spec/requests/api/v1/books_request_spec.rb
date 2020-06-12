require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  include JwtAuthenticatable

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  let(:book) { create(:book, user_id: user.id) }
  let!(:other_book) { create(:book, user_id: other_user.id) }

  let(:headers_with_token) { { CONTENT_TYPE: "application/json", Authorization: encode(user.id) } }
  let(:headers_without_token) { { CONTENT_TYPE: "application/json" } }

  before do
    allow(ImgurImageUpload).to receive(:upload_image).and_return('http://i.imgur.com/2ElUhgK.jpg')
  end

  describe "GET /books" do
    subject { get api_v1_books_path, headers: headers_with_token }

    it { is_expected.to eq 200 }
  end

  describe "POST /books" do
    subject do
      post api_v1_books_path, params: params.to_json, headers: headers
    end

    context "response success" do
      let(:params) { attributes_for(:book) }
      let(:headers) { headers_with_token }

      it { is_expected.to eq 200 }
    end

    context "response error" do
      context "without token" do
        let(:params) { attributes_for(:book) }
        let(:headers) { headers_without_token }

        it "can't resister book" do
          expect { raise StandardError }.to raise_error
        end
      end

      context "without book name" do
        let(:params) { attributes_for(:book, :invalid) }
        let(:headers) { headers_with_token }

        it "can't resister book" do
          expect { subject }.not_to change(Book, :count)
          expect(JSON.parse(response.body)["error"]).to be_present
        end
      end
    end
  end

  describe "PATCH /books/:id" do
    context "response success" do
      subject { patch "/api/v1/books/#{book.id}", params: params.to_json, headers: headers }

      let(:params) { attributes_for(:book, :new_book) }
      let(:headers) { headers_with_token }

      it { is_expected.to eq 200 }
    end

    context "response error" do
      context "without token" do
        subject { patch "/api/v1/books/#{book.id}", params: params.to_json, headers: headers }

        let(:params) { attributes_for(:book, :new_book) }
        let(:headers) { headers_without_token }

        it "can't update" do
          expect { raise StandardError }.to raise_error
        end
      end

      context "when book is not related to current_user" do
        subject { patch "/api/v1/books/#{other_book.id}", params: params.to_json, headers: headers }

        let(:params) { attributes_for(:book, :new_book) }
        let(:headers) { headers_with_token }

        it "can't update" do
          expect { subject }.not_to change { other_book }
        end
      end
    end
  end
end
