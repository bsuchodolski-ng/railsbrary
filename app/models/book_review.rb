class BookReview < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :book_id, presence: true,
                      uniqueness: { scope: :user_id, message: "was already reviewed" }
  validates :user_id, presence: true
  validates :body, presence: true

  def rating
    book_rating = book.book_ratings.find_by_user_id(user_id)
    if book_rating
      book_rating.rating
    else
      nil
    end
  end

end
