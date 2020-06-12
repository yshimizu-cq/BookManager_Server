class Api::V1::BooksController < ApplicationController
  include JwtAuthenticator
  before_action :jwt_authenticate

  def index
    books = current_user.books.page(params[:page]).per(20)
    render_success_response(200, books)
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      render_success_response(200, book)
    else
      render_failure_response(400, book.errors.full_messages)
    end
  end

  def update
    book = current_user.books.find_by(id: params[:id])
    return render_failure_response(400, book.errors.full_messages) unless book # rerurnで処理を終える
    if book.update_attributes(book_params)
      render_success_response(200, book)
    else
      render_failure_response(400, book.errors.full_messages)
    end
  end

  private

  def book_params
    params.permit(:image_url, :name, :price, :purchase_date)
  end
end
