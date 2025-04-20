class ListBook < ApplicationRecord
  belongs_to :list
  belongs_to :book

  validates :read_completed_at, presence: true
end
