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

  def show
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Book successfully created'
      redirect_to @book
    else
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author_id)
  end
end
