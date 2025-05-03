class ListsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @books = Book.order(created_at: :asc)
    @user = User.find_by(id: 2)
    @read_completed_dates = @user.lists.joins(:list_books).pluck('list_books.read_completed_at')
    @comments = @user.lists.joins(:list_books).pluck('list_books.comment')
  end

  def update
  end

  def destroy
  end
end
