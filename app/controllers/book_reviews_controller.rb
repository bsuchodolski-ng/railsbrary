class BookReviewsController < ApplicationController
  def new
    @book_review = BookReview.new(book_id: params[:book_id], user_id: current_user.id)
  end
end
