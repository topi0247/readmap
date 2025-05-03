class BooksController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :set_current_user_list, only: [:new, :create, :edit, :update, :destroy]

  def new
    search_params = params.permit(:title, :commit, :list_id)
    @result = RakutenBooksApiService.search(search_params[:title]) if search_params[:title].present?

    @books = @list.books
    @existing_isbns = @books.pluck(:isbn)
  end

  def create
    begin
      book = Book.find_or_create_by!(isbn: books_params[:isbn]) do |b|
        b.title = books_params[:title]
        b.cover_image_url = books_params[:cover_image_url]
        b.url = books_params[:url]
      end

      unless @list.books.include?(book)
        @list.list_books.find_or_create_by!(list_id: @list.id, book_id: book.id) do |list_book|
          list_book.read_completed_at = books_params[:read_completed_at]
          list_book.comment = books_params[:comment]
        end
        book_and_list_reload
      end

      respond(book)

      flash.now[:success] = "リストに登録完了しました"
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Error creating book: #{e.message}")
      flash.now[:error] = "本の登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    book = Book.find_by(isbn: params[:id])
    begin
      if book
        @list.list_books.find_by(book_id: book.id)&.destroy!
      else
        flash.now[:error] = "本が見つかりません"
      end

      book_and_list_reload

      respond(book)
      flash.now[:success] = "本をリストから削除しました"
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Error deleting book: #{e.message}")
      flash.now[:error] = "本の削除に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def books_params
    params.permit(
    :title, :isbn, :cover_image_url, :url,
    :read_completed_at, :comment, :list_id
  )
  end

  def set_current_user_list
    @list = current_user.lists.find_by(id: params[:list_id])
    unless @list
      redirect_to lists_path, error: "リストが見つかりません"
    end
  end

  def respond(book)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "book_#{book.isbn}",
          partial: 'book',
          locals: {
            book: book.as_json.symbolize_keys,
            list: @list,
            existing_isbns: @existing_isbns
          }
        )
      end
    end
  end

  def book_and_list_reload
    @books = @list.books.reload
    @existing_isbns = @books.pluck(:isbn)
  end
end
