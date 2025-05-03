class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  include SessionsHelper
  add_flash_types :success, :warning
  
  def require_login
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end
end