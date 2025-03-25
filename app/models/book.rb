class Book < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :list_books, dependent: :destroy
  has_many :lists, through: :list_books
  
  validates :title, presence: true
end