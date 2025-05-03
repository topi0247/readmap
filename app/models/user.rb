class User < ApplicationRecord
  has_many :lists, dependent: :destroy
  has_one :authentication, dependent: :destroy

  validates :name, presence: true
  scope :publicly_visible, -> { where(is_public: true) }
end