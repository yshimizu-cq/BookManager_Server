class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by(token: request.headers['Authorization'].split[1])
  end

  def render_success_response(status, result)
    render json: { status: status, result: result }
  end

  def render_failure_response(status, error)
    render json: { status: status, error: error }
  end
end
