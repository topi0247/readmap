class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

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

  def user_params
    params.require(:user).permit(:name, :engineer_start_date, :profile_content, :is_public)
  end
end
