class Author < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  scope :with_name, lambda { |name| where("name ilike ?", "%#{name}%") }
end
