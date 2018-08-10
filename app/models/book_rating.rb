class BookRating < ApplicationRecord
  after_commit :recalculate_book_average_rating

  belongs_to :book, counter_cache: true
  belongs_to :user

  validates :book_id, presence: true,
                      uniqueness: { scope: :user_id, message: "was already rated" }
  validates :user_id, presence: true
  validates :rating, presence: true,
                     inclusion: 1..5

  private

  def recalculate_book_average_rating
    book&.recalculate_average_rating
  end
end
