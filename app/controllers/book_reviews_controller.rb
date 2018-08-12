class BookReviewsController < ApplicationController
  def new
    @book_review = BookReview.new(book_id: params[:book_id], user_id: current_user.id)
  end

  def create
    @book_review = BookReview.new(book_review_params)
    if @book_review.save
      render
    else
      render 'new'
    end
  end

  private

  def book_review_params
    params.require(:book_review).permit(:book_id, :user_id, :body)
  end
end
