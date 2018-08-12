class BookReviewsController < ApplicationController
  def new
    @book_review = BookReview.new(book_id: params[:book_id], user_id: current_user.id)
  end

  def create
    @book_review = BookReview.new(book_review_params)
    render 'new' unless @book_review.save
  end

  def edit
    @book_review = BookReview.find(params[:id])
  end

  def update
    @book_review = BookReview.find(params[:id])
    render 'edit' unless @book_review.update(book_review_params)
  end

  private

  def book_review_params
    params.require(:book_review).permit(:book_id, :user_id, :body)
  end
end
