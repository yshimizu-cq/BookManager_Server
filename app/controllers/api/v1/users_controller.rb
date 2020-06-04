class Api::V1::UsersController < ApplicationController
  def sign_up
    sign_up_user = User.new(user_params)
    if sign_up_user.save
      render json: { status: "200", result: sign_up_user }
    else
      render json: { status: "400", error: sign_up_user.errors.full_messages }
    end
  end

  def login
    login_user = User.find_by(email: params[:email].downcase)
    if login_user && login_user.authenticate(params[:password])
      render json: { status: "200", result: login_user }
    else
      render json: { status: "401", error: "ログインに失敗しました" }
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
