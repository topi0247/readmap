# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = User.create!([
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
])

# 認証情報
Authentication.create!([
  { user: users[0], email: "ranten@example.com", provider: "google" },
  { user: users[1], email: "rubi@example.com", provider: "google" },
  { user: users[2], email: "enzi@example.com", provider: "google" }
])

# カテゴリ
categories = Category.create!([
  { name: "Ruby" },
  { name: "Typescript" },
  { name: "Python" },
  { name: "AWS" },
  { name: "データベース" },
  { name: "インフラ" },
  { name: "WEB技術" },
  { name: "キャリア" }
])

# 書籍
books = Book.create!([
  { title: "「エンジニア×スタートアップ」こそ、最高のキャリアである", url: "https://books.rakuten.co.jp/rb/17314436/?l-id=search-c-item-text-05", isbn: "9784295407775" },
  { title: "マンガでわかるデータベース", url: "https://books.rakuten.co.jp/rb/3712479/?l-id=search-c-item-text-01", isbn: "9784274066313" },
  { title: "イラスト図解式 この一冊で全部わかるWeb技術の基本", url: "https://books.rakuten.co.jp/rb/14674807/?l-id=item-c-reco-slider&rtg=103322d9a83bee379262ea7a59a2dc51", isbn: "9784797388817" },
  { title: "ゼロからわかるRuby超入門はじめてのプログラミング（かんたんIT基礎講座）", url: "https://books.rakuten.co.jp/rb/15664673/?l-id=item-c-reco-slider&rtg=103322d9a83bee379262ea7a59a2dc51", isbn: "9784297101237" },
])

# 書籍とカテゴリの関連付け
BookCategory.create!([
  { book: books[0], category: categories[7] },
  { book: books[1], category: categories[4] },
  { book: books[2], category: categories[6] },
  { book: books[3], category: categories[0] },
])

# リスト
lists = List.create!([
  { name: "マイリスト01", user: users[0], is_public: true },
  { name: "マイリスト02", user: users[0], is_public: true },
  { name: "マイリスト03", user: users[1], is_public: true },
  { name: "マイリスト04", user: users[2], is_public: false }
])

# リストと書籍の関連付け
ListBook.create!([
  { list: lists[0], book: books[1], read_completed_at: nil, comment: "You must read" },
  { list: lists[1], book: books[0], read_completed_at: Date.new(2024, 2, 10), comment: "とても参考になった" },
  { list: lists[2], book: books[2], read_completed_at: nil, comment: "基本知識得られた" },
  { list: lists[3], book: books[3], read_completed_at: Date.new(2023, 12, 15), comment: "ぱない" }
])