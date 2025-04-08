# ユーザーの作成
users = [
  {
    name: "乱天 君子",
    engineer_start_date: Date.new(2024, 4, 1),
    profile_content: "WEBアプリ開発スクールを経営しています",
    is_public: true
  },
  {
    name: "流美 玲流",
    engineer_start_date: Date.new(2023, 10, 1),
    profile_content: "ゾウさんが好きです。でもRuby on Railsがもっと好きです",
    is_public: true
  },
  {
    name: "園児 ニア",
    engineer_start_date: Date.new(2019, 1, 1),
    profile_content: "エンジニアです",
    is_public: false
  }
]

created_users = users.map do |user_data|
  User.find_or_create_by!(name: user_data[:name]) do |user|
    user.engineer_start_date = user_data[:engineer_start_date]
    user.profile_content = user_data[:profile_content]
    user.is_public = user_data[:is_public]
  end
end

# 認証情報
authentications = [
  { user: created_users[0], email: "ranten@example.com", provider: "google" },
  { user: created_users[1], email: "rubi@example.com", provider: "google" },
  { user: created_users[2], email: "enzi@example.com", provider: "google" }
]

authentications.each do |auth_data|
  Authentication.find_or_create_by!(user_id: auth_data[:user].id, email: auth_data[:email]) do |auth|
    auth.provider = auth_data[:provider]
  end
end

# カテゴリ
category_names = [
  "Ruby",
  "Typescript",
  "Python",
  "AWS",
  "データベース",
  "インフラ",
  "WEB技術",
  "キャリア"
]

created_categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end

# 書籍
books_data = [
  {
    title: "「エンジニア×スタートアップ」こそ、最高のキャリアである",
    url: "https://books.rakuten.co.jp/rb/17314436/?l-id=search-c-item-text-05",
    isbn: "9784295407775"
  },
  {
    title: "マンガでわかるデータベース",
    url: "https://books.rakuten.co.jp/rb/3712479/?l-id=search-c-item-text-01",
    isbn: "9784274066313"
  },
  {
    title: "イラスト図解式 この一冊で全部わかるWeb技術の基本",
    url: "https://books.rakuten.co.jp/rb/14674807/?l-id=item-c-reco-slider&rtg=103322d9a83bee379262ea7a59a2dc51",
    isbn: "9784797388817"
  },
  {
    title: "ゼロからわかるRuby超入門はじめてのプログラミング（かんたんIT基礎講座）",
    url: "https://books.rakuten.co.jp/rb/15664673/?l-id=item-c-reco-slider&rtg=103322d9a83bee379262ea7a59a2dc51",
    isbn: "9784297101237"
  }
]

created_books = books_data.map do |book_data|
  Book.find_or_create_by!(isbn: book_data[:isbn]) do |book|
    book.title = book_data[:title]
    book.url = book_data[:url]
  end
end

# 書籍とカテゴリの関連付け
book_categories = [
  { book: created_books[0], category: created_categories[7] },
  { book: created_books[1], category: created_categories[4] },
  { book: created_books[2], category: created_categories[6] },
  { book: created_books[3], category: created_categories[0] }
]

book_categories.each do |bc_data|
  BookCategory.find_or_create_by!(book_id: bc_data[:book].id, category_id: bc_data[:category].id)
end

# リスト
lists_data = [
  { name: "マイリスト01", user: created_users[0], is_public: true },
  { name: "マイリスト02", user: created_users[0], is_public: true },
  { name: "マイリスト03", user: created_users[1], is_public: true },
  { name: "マイリスト04", user: created_users[2], is_public: false }
]

created_lists = lists_data.map do |list_data|
  List.find_or_create_by!(name: list_data[:name], user_id: list_data[:user].id) do |list|
    list.is_public = list_data[:is_public]
  end
end

# リストと書籍の関連付け
list_books = [
  {
    list: created_lists[0],
    book: created_books[1],
    read_completed_at: nil,
    comment: "You must read"
  },
  {
    list: created_lists[1],
    book: created_books[0],
    read_completed_at: Date.new(2024, 2, 10),
    comment: "とても参考になった"
  },
  {
    list: created_lists[2],
    book: created_books[2],
    read_completed_at: nil,
    comment: "基本知識得られた"
  },
  {
    list: created_lists[3],
    book: created_books[3],
    read_completed_at: Date.new(2023, 12, 15),
    comment: "ぱない"
  }
]

list_books.each do |lb_data|
  ListBook.find_or_create_by!(list_id: lb_data[:list].id, book_id: lb_data[:book].id) do |list_book|
    list_book.read_completed_at = lb_data[:read_completed_at]
    list_book.comment = lb_data[:comment]
  end
end
