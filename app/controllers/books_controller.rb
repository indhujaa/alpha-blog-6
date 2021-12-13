class BooksController < ApplicationController
  before_action :set_book,only: [:show,:edit,:update,:destroy]
  before_action :require_user?,except: [:show,:index]
  before_action :require_same_user?,only: [:edit,:destroy,:update]
  def show
  end
  def index
    @books=Book.paginate(page: params[:page],per_page: 3)
  end
  def new
    @book=Book.new()
  end
  def edit
  end
  def create
    # render plain: params[:a]
    @book=Book.new(book_param)
    @book.user=current_user
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
    params.require(:book).permit(:title,:description,:author,category_ids:[])
  end
  def require_same_user?
    if(current_user!=@book.user && !current_user.admin?)
      flash[:alert]="You can only edit your own Book"
      redirect_to book_path(@book)
    end
  end
end
