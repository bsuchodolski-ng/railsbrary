class BooksController < UsersBaseController

  def index
    @books = Book.where(nil)
    if params[:filters].present?
      params[:filters].each do  |key, value|
        @books = @books.public_send(key, value) if value.present?
      end
    end
    @books = @books.where('title ILIKE ?', "%#{params[:term]}%")
                   .page(params[:page])
                   .includes(:author)
  end

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_rating = @book.book_ratings.find_by_user_id(current_user.id) || @book.book_ratings.new(user: current_user)
  end

  def create
    @book = Book.new(book_params)
    @book.published_at = parse_date(book_params[:published_at])
    @book.cover_image = book_params[:cover_image]
    if @book.save
      flash[:success] = 'Book successfully created'
      redirect_to @book
    else
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :description, :author_id, :cover_image, :published_at)
  end

  def parse_date(date)
    begin
      DateTime.strptime(date, "%Y-%m-%d")
    rescue
      nil
    end
  end
end
