class BookRatingsController < ApplicationController

  def create
    @book_rating = BookRating.new(book_rating_params)
    @book_rating.save
  end

  def update
    @book_rating = BookRating.find_by(book_id: book_rating_params[:book_id],
                                      user_id: book_rating_params[:user_id])
    if book_rating_params[:rating].present?
      @book_rating.update(book_rating_params)
      @book_rating.save
    else
      @book_rating.destroy
      @book_rating = @book_rating = BookRating.new(book_rating_params.except(:rating))
    end
  end

  private

  def book_rating_params
    params.require(:book_rating).permit(:book_id, :user_id, :rating)
  end
end
