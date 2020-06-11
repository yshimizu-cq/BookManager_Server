class Api::V1::UsersController < ApplicationController
  include JwtAuthenticator

  def sign_up
    sign_up_user = User.new(user_params)
    if sign_up_user.save
      response.headers['X-Authentication-Token'] = encode(sign_up_user.id) # jwtを発行しレスポンスヘッダーに設定
      render_success_response(200, { id: sign_up_user.id,
                                     email: sign_up_user.email,
                                     token: encode(sign_up_user.id) })
    else
      render_failure_response(400, sign_up_user.errors.full_messages)
    end
  end

  def login
    login_user = User.find_by(email: params[:email])
    if login_user && login_user.authenticate(params[:password])
      render_success_response(200, { id: login_user.id,
                                     email: login_user.email,
                                     token: encode(login_user.id) })
    else
      render_failure_response(401, I18n.t('errors.messages.invalid_email_or_password'))
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
