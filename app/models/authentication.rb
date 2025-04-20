class Authentication < ApplicationRecord
  belongs_to :user

  validates :email, presence: true
  validates :provider, presence: true
end