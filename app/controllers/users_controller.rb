class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authorize_user, only: [:edit, :update]
  skip_before_action :require_login, only: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    @users = User.publicly_visible.order(created_at: :desc).includes(:lists)
  end

  def show
    unless @user.is_public
      # ログインユーザーが自分自身の場合は表示、それ以外はリダイレクト
      unless current_user&.id == @user.id
        redirect_to users_path, warning: "表示権限がありません"
      end
    end
  end

  def edit; end

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
      redirect_to user_path(params[:id]), success: "ユーザー情報を更新しました"
    else
      flash.now[:warning] = "ユーザー情報の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user
    unless current_user && current_user.id == @user.id
      redirect_to users_path, warning: "他のユーザー情報は編集できません"
    end
  end

  def user_not_found
    redirect_to users_path, warning: "指定されたユーザーは存在しません"
  end

  def user_params
    params.require(:user).permit(:name, :engineer_start_date, :profile_content, :is_public)
  end
end
