class ApplicationController < ActionController::API  
  def current_user
    # メモ化（2回目以降、@current_userが未定義でnilなのか計算した結果がnilなのかを区別して処理）
    return @current_user if instance_variable_defined?(:@current_user)
    @current_user = User.find_by(token: request.headers['Authorization'].split[1])
  end

  def render_success_response(status, result)
    render json: { status: status, result: result }
  end

  def render_failure_response(status, error)
    render json: { status: status, error: error }
  end
end

# @current_user ||= User.find_by(token: request.headers['Authorization'].split[1]) コードで確認する => 舘さん連絡