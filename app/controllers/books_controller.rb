class BooksController < ApplicationController

  def index
    @books = Book.where(nil)
    if params[:filters].present?
      @books = @books.with_author(params[:filters][:author])
    end
    @books = @books.where("title ILIKE ?", "%#{params[:term]}%")
  end

  def new
    @book = Book.new
  end
end
