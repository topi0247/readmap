class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]
  before_action :require_login
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    @users = User.publicly_visible.order(created_at: :desc).includes(:lists) 
  end
  
  def show
    unless @user.is_public
      # ログインユーザーが自分自身の場合は表示、それ以外はリダイレクト
      unless current_user && current_user.id == @user.id
        flash[:alert] = "このユーザーページは非公開に設定されています"
        redirect_to users_path and return
      end
    end
  end

  def edit
    # authorize_userメソッドで処理
  end

  def update
    # authorize_userメソッドで処理
    if @user.update(user_params)
      # ユーザーが非公開になるとリストも全て非公開にする
      unless @user.is_public
        @user.lists.each do |list|
          list.is_public = false
          list.save!
        end
      end
      redirect_to user_path(params[:id]), notice: "ユーザー情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user && current_user.id == @user.id
      flash[:alert] = "他のユーザー情報は編集できません"
      redirect_to users_path and return
    end
  end

  def user_not_found
    flash[:alert] = "指定されたユーザーは存在しません"
    redirect_to users_path
  end


  def user_params
    params.require(:user).permit(:name, :engineer_start_date, :profile_content, :is_public)
  end
end
