class List < ApplicationRecord
  belongs_to :user
  has_many :list_books, dependent: :destroy
  has_many :books, through: :list_books

  validates :name, presence: true
  validates :is_public, inclusion: { in: [true, false] }
end