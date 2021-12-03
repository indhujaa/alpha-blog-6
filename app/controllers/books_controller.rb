class BooksController < ApplicationController
  before_action :set_book,only: [:show,:edit,:update,:destroy]
  def show
  end
  def index
    @books=Book.all
  end
  def new
    @book=Book.new()
  end
  def edit
  end
  def create
    # render plain: params[:a]
    @book=Book.new(book_param)

    if @book.save()
      flash[:notice]="Book Added successfully"
      redirect_to @book
    else
      render "new"
    end
  end
  def update
    check=@book.update(book_param)
    if check
      flash[:notice]="Book Updated successfully"
      redirect_to @book
    else
      render "edit"
    end
  end
  def destroy
      @book.destroy
      flash[:notice]="Book Deleted successfully"
      redirect_to books_path
  end


  private
  def set_book
    @book=Book.find(params[:id])
  end
  def book_param
    params.require(:book).permit(:title,:description,:author)
  end

end
