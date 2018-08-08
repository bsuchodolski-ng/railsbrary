class AuthorsController < UsersBaseController

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: @author
    else
      render json: @author.errors.full_messages
    end
  end

  private

  def author_params
    params.require(:author).permit(:name)
  end
end
