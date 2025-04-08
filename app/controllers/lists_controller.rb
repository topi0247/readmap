class ListsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @books = Book.all
    @user = User.find_by(id: 1)
  end

  def update
  end

  def destroy
  end
end
