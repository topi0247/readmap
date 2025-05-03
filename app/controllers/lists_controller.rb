class ListsController < ApplicationController
  before_action :set_current_user_list, only: [:edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]

  def index
    # TODO: ログインユーザーも除く
    @non_current_users = User.where(is_public: true).includes(:lists)
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to new_list_book_path(list_id: @list.id), success: 'リストを作成しました'
    else
      flash.now[:warning] = 'リスト作成に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find_by(id: params[:id])
    if @list.nil?
      redirect_to lists_path, warning: "リストがありません"
    else
      @list_books = @list.list_books.includes(:book)
    end
  end

  def edit; end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list), success: 'リストを更新しました'
    else
      flash.now[:warning] = 'リスト更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @list.destroy
      redirect_to user_path(current_user), success: 'リストを削除しました'
    else
      flash.now[:warning] = 'リスト削除に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :is_public)
  end

  def set_current_user_list
    @list = current_user.lists.find_by(id: params[:id])
    unless @list
      redirect_to lists_path, error: "リストが見つかりません"
    end
  end
end
