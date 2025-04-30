class Api::V1::BooksController < ApplicationController
  def search
    data = RakutenBooksApiService.search(books_params[:title])
    if data
      render json: data, status: :ok
    else
      render json: { error: "エラーが発生しました" }, status: :internal_server_error
    end
  end

  private

  def books_params
    params.permit(:title)
  end
end
