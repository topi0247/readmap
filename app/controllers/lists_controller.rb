class ListsController < ApplicationController
  def index
    @non_current_users = User.find_by(id: 1)
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
