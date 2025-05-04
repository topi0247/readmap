class BooksController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :set_current_user_list, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_current_user_list_book, only: [:edit, :update]

  def new
    search_params = params.permit(:title, :commit, :list_id)
    @result = RakutenBooksApiService.search(search_params[:title]) if search_params[:title].present?

    @books = @list.books
    @categories = Category.all
    @existing_isbns = @books.pluck(:isbn)
  end

  def create
    begin
      book = Book.find_or_create_by!(isbn: books_params[:isbn]) do |b|
        b.title = books_params[:title]
        b.cover_image_url = books_params[:cover_image_url]
        b.url = books_params[:url]
      end

      if book.categories.nil? || book.categories.count < 3
        category_ids = books_params[:categories].map do |category_name|
          Category.find_by_name(category_name)&.id
        end.compact
        book.categories = Category.where(id: category_ids)
      end

      unless @list.books.include?(book)
        @list.list_books.find_or_create_by!(list_id: @list.id, book_id: book.id) do |list_book|
          list_book.read_completed_at = books_params[:read_completed_at]
          list_book.comment = books_params[:comment]
        end
        books_and_list_reload
      end

      respond(book)

      flash.now[:success] = "リストに登録完了しました"
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Error creating book: #{e.message}")
      flash.now[:warning] = "本の登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @list = List.find_by(id: params[:list_id])
    unless @list
      redirect_to lists_path, warning: "リストが見つかりません"
      return
    end

    @list_book = @list.list_books.find_by(list_id: @list.id, book_id: params[:id])
    unless @list_book
      redirect_to lists_path, warning: "リストに本が見つかりません"
      return
    end

    @book = Book.find_by(id: params[:id])
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    if @list_book.update(list_book_params)
      flash.now[:success] = "本の情報を更新しました"
      redirect_to list_book_path(@list, @list_book.book_id), status: :see_other
    else
      flash.now[:warning] = "本の情報の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      book = Book.find_by(isbn: params[:id])
      if book
        @list.list_books.find_by(book_id: book.id)&.destroy!
      else
        flash.now[:error] = "本が見つかりません"
      end

      if request.referer&.match(%r{/lists/\d+/books/new})
        books_and_list_reload
        respond(book)
        flash.now[:success] = "本をリストから削除しました"
        return
      end

      redirect_to list_path(@list.id), success: "本をリストから削除しました"
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("Error deleting book: #{e.message}")
      flash.now[:warning] = "本の削除に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def books_params
    params.permit(
    :title, :isbn, :cover_image_url, :url,
    :read_completed_at, :comment, :list_id,
    categories: []
  )
  end

  def list_book_params
    params.require(:list_book).permit(
      :read_completed_at, :comment
    )
  end

  def set_current_user_list
    @list = current_user.lists.find_by(id: params[:list_id])
    unless @list
      redirect_to lists_path, warning: "リストが見つかりません"
    end
  end

  def set_current_user_list_book
    @list_book = @list.list_books.find_by(list_id: @list.id, book_id: params[:id])
    unless @list_book
      redirect_to lists_path, warning: "リストに本が見つかりません"
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

  def books_and_list_reload
    @books = @list.books.reload
    @existing_isbns = @books.pluck(:isbn)
  end
end
