class BookRatingPolicy < ApplicationPolicy
  attr_reader :user, :book_rating

  def initialize(user, book_rating)
    @user = user
    @book_rating = book_rating
  end

  def create?
    @book_rating.user_id == @user.id
  end

  def update?
    @book_rating.user_id == @user.id
  end
end
