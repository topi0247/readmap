class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    @users = User.publicly_visible.order(created_at: :desc).includes(:lists) 
  end
  
  def show
    unless @user.is_public
      
      #TODO: ログイン機能実装後、current_userに一致せず、かつ非公開の場合は一覧に遷移するロジックを追加
      # if current_user && current_user.id == @user.id
      # # 自分自身のページなのでアクセス許可
      # else
      # 他のユーザーの非公開ページなのでリダイレクト
      # TODO: フラッシュメッセージを実装予定
      # 　flash[:alert] = "このユーザーページは非公開に設定されています"
      # 　redirect_to users_path and return
      # end

      # ログイン機能実装までの暫定対応
      redirect_to users_path and return
    end
  end

  def edit
    # TODO：ログイン機能実装後下記の追加予定
    # unless current_user && current_user.id == @user.id
    #   flash[:alert] = "他のユーザー情報は編集できません"
    #   redirect_to users_path and return
    # end# unless current_user && current_user.id == @user.id
    #   flash[:alert] = "他のユーザー情報は編集できません"
    #   redirect_to users_path and return
    # end
  end

  def update
    # TODO：ログイン機能実装後下記の追加予定
    # unless current_user && current_user.id == @user.id
    #   flash[:alert] = "他のユーザー情報は更新できません"
    #   redirect_to users_path and return
    # end

    if @user.update(user_params)
      # ユーザーが非公開になるとリストも全て非公開にする
      unless @user.is_public
        @user.lists.each do |list|
          list.is_public = false
          list.save!
        end
      end
      redirect_to user_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_not_found
    # TODO: フラッシュメッセージを実装予定
    # flash[:alert] = "指定されたユーザーは存在しません"
    redirect_to users_path
  end


  def user_params
    params.require(:user).permit(:name, :engineer_start_date, :profile_content, :is_public)
  end
end
