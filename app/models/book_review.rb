class BookReview < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, presence: true,
                      uniqueness: { scope: :user_id, message: "was already reviewed" }
  validates :user_id, presence: true
  validates :body, presence: true
end
