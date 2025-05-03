class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    auth = auth_hash
    authentication = Authentication.find_or_initialize_by(email: auth.info.email, provider: auth.provider)

    if authentication.new_record?
      user = User.create!(name: auth.info.name)
      authentication.user = user
    end

    if authentication.save
      session[:user_id] = authentication.user.id
      flash[:success] = 'ログインしました'
      redirect_to root_path
    else
      flash[:warning] = "ログインに失敗しました。"
      redirect_to root_path
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path, success: 'ログアウトしました'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
