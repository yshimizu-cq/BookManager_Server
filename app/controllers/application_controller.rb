class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def current_user
    # メモ化（2回目以降、@current_userが未定義でnilなのか計算した結果がnilなのかを区別するため）
    return @current_user if instance_variable_defined?(:@current_user)
    @current_user = User.find_by(token: request.headers['Authorization'].split[1])
  end
end
