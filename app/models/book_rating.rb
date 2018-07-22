class BookRating < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, presence: true,
                      uniqueness: { scope: :user_id, message: "was already rated" }
  validates :user_id, presence: true
  validates :rating, presence: true,
                     inclusion: 1..5
end
