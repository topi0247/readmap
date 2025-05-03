class ApplicationController < ActionController::Base
  add_flash_types :success, :warning
  helper_method :current_user, :logged_in?
  before_action :require_login

  def require_login
    redirect_to root_path, warning: "ログインしてください" unless logged_in?
  end

  def current_user
    return unless (user_id = session[:user_id])
    @current_user ||= User.find_by(id: user_id)
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end