class BooksController < ApplicationController

  def index
    @books = Book.where("title ILIKE ?", "%#{params[:term]}%")
  end
end
