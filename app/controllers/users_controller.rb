class UsersController < ApplicationController
  before_action :set_user,only: [:edit,:update,:show,:destroy]
  before_action :require_user?,except: [:show,:index,:create,:new]
  before_action :require_same_user?,only: [:edit,:update,:destroy]
  def new
    @user=User.new
  end
  def create
    @user=User.new(user_param)
    if @user.save()
      session[:user_id]=@user.id
      flash[:notice]="Welcome "+@user.username+"!! to Alpha Blog "
      redirect_to user_path(@user.id)
    else
      render "new"
    end
  end
  def edit

  end
  def update

    if(@user.update(user_param))
      flash[:notice]="User Details Updated successfully"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @books=@user.books.paginate(page: params[:page],per_page: 3)

  end

  def index
    @users=User.paginate(page: params[:page],per_page: 3)
  end

  def destroy
    @user.destroy
    if current_user==@user
      session[:user_id]=nil
      flash[:notice]="User and Associated books Deleted successfully"
      redirect_to root_path
    else
      flash[:notice]="User and Associated books Deleted successfully"
      redirect_to users_path
    end
  end

  private
  def user_param
    params.require(:user).permit(:username,:email,:password)
  end
  def set_user
    @user=User.find(params[:id])
  end
  def require_same_user?
    if(current_user!=@user && !current_user.admin?)
      flash[:alert]="You can edit only your own Profile";
      redirect_to user_path(@user)
    end
  end
end
