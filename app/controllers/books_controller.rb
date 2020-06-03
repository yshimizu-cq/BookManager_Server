class BooksController < ApplicationController
  before_action :authenticate

  def index
    books = current_user.books.(page: params[:page]).per(20)
    render json: { statfus: "200", data: books }
  end

  def create
    book = current_user.books.build(book_params)
    if book.save
      render json: { status: "200", data: book }
    else
      render json: { status: "400", data: book.errors.fullmessages }
    end
  end

  def update
    book = current_user.books.find(params[:id])
    if book.update_attributes(book_params)
      render json: { status: "200", data: book }
    else
      render json: { status: "400", data: book.errors.fullmessages }
    end
  end

  private

    def book_params
      params.requre(:book).permit(:image_url, :name, :price, :purchase_date)
    end

end
