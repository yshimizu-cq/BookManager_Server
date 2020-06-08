class Api::V1::UsersController < ApplicationController
  include JwtAuthenticator

  def sign_up
    sign_up_user = User.new(user_params)
    if sign_up_user.save
      response.headers['X-Authentication-Token'] = encode(sign_up_user.id) # jwtを発行しレスポンスヘッダーに設定
      render json: {
        status: "200",
        result: { id: sign_up_user.id, email: sign_up_user.email, token: encode(sign_up_user.id) },
      }
    else
      render json: {
        status: "400",
        error: sign_up_user.errors.full_messages,
      }
    end
  end

  def login
    login_user = User.find_by(email: params[:email].downcase)
    if login_user && login_user.authenticate(params[:password])
      response.headers['X-Authentication-Token'] = encode(login_user.id) # jwtを発行しレスポンスヘッダーに設定
      render json: {
        status: "200",
        result: { id: login_user.id, email: login_user.email, token: encode(login_user.id) },
      }
    else
      render json: {
        status: "401",
        error: "ログインに失敗しました",
      }
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
