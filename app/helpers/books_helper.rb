module BooksHelper
  def hasCategory?(isbn)
    book = Book.find_by_isbn(isbn)
    if book&.categories.present?
      categories = book.categories.map(&:name)
      if book.categories.count < 3
        categories << '未設定'
      end
      categories
    else
      ["未設定","未設定","未設定"]
    end
  end
end
