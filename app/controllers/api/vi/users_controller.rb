class Api::Vi::UsersController < ApplicationController
  def sign_up
    sign_up_user = User.new(user_params)
    if sign_up_user.save
      render json: { status: "200", data: user }
    else
      render json: { status: "400", data: user.errors.fullmessages }
    end
  end

  def login
    login_user = User.find_by(email: params[:email].downcase)
    if login_user && login_user.authenticate(params[:password])
      render json: { status: "200", data: login_user }
    else
      render json: { status: "401" }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
