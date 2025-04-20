class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_one :authentication, dependent: :destroy

  validates :name, presence: true
end