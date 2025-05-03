class ListsController < ApplicationController
  def index
    # TODO: ログインユーザーも除く
    @non_current_users = User.where(is_public: true).includes(:lists)
  end

  def new
  end

  def create
  end

  def show
    @books = Book.order(created_at: :asc)
    @user = User.find_by(id: 1)
  end

  def update
  end

  def destroy
  end
end
