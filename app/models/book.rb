class Book < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :list_books, dependent: :destroy
  has_many :lists, through: :list_books

  validates :title, presence: true
  validates :url, presence: true, format: { with: URI::regexp(%w[http https]), message: 'URLが不正です' }
  validates :isbn, presence: true, uniqueness: true, format: { with: /\A\d{10}(\d{3})?\z/, message: 'ISBNは10桁または13桁の数字でなければなりません' }
  validates :cover_image_url, presence: true, format: { with: URI::regexp(%w[http https]), message: '表紙画像のURLが不正です' }
end