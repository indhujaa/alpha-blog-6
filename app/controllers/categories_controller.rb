class CategoriesController < ApplicationController
  before_action :set_category,only: [:show,:edit,:update]
  before_action :require_admin,except: [:show,:index]
  def new
    @category=Category.new();
  end
  def show
    @books=@category.books.paginate(page: params[:page],per_page:3)
  end
  def index
    @categories=Category.paginate(page: params[:page],per_page:3)
  end
  def create
    @category=Category.new(category_param)
    if @category.save
      flash[:notice]="Category Created successfully"
      redirect_to @category
    else
      render "new"
    end
  end
  def edit
  end
  def update
    if @category.update(category_param)
      flash[:notice]="Category Updated successfully"
      redirect_to @category
    else
      render :new
    end

  end
  private
  def category_param
    params.require(:category).permit(:name)
  end
  def set_category
    @category=Category.find(params[:id])
  end
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert]="One Admin have access to create or update categories"
      redirect_to categories_path
    end
  end
end
