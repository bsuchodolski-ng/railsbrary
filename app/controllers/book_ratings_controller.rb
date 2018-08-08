class BookRatingsController < ApplicationController

  def create
    @book_rating = BookRating.new(book_rating_params)
    @book_rating.save
  end

  private

  def book_rating_params
    params.require(:book_rating).permit(:book_id, :user_id, :rating)
  end
end
