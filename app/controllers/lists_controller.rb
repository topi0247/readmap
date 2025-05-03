class ListsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    list = List.find_by(id: params[:id])
    if list.nil?
      redirect_to lists_path, warning: "リストがありません"
    else
      @list_books = list.list_books.includes(:book)
    end
  end

  def update
  end

  def destroy
  end
end
