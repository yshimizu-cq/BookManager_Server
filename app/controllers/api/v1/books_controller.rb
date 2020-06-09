class Api::V1::BooksController < ApplicationController
  include JwtAuthenticator
  before_action :jwt_authenticate

  def index
    books = current_user.books.page(params[:page]).per(20)
    render json: { status: "200", result: books }
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      render json: { status: "200", result: book }
    else
      render json: { status: "400", error: book.errors.full_messages }
    end
  end

  def update
    book = current_user.books.find(params[:id])
    if book.update_attributes(book_params)
      render json: { status: "200", result: book }
    else
      render json: { status: "400", error: book.errors.full_messages }
    end
  end

  private

  def book_params
    params.permit(:image_url, :name, :price, :purchase_date)
  end
end
