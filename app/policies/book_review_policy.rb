class BookReviewPolicy < ApplicationPolicy
  attr_reader :user, :book_review

  def initialize(user, book_review)
    @user = user
    @book_review = book_review
  end

  def create?
    @book_review.user_id == @user.id
  end

  def new?
    create?
  end

  def update?
    @book_review.user_id == @user.id
  end

  def edit?
    update?
  end

  def destroy?
    @book_review.user_id == @user.id
  end
end
