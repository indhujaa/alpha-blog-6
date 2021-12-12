class SessionsController < ApplicationController
  def new

  end
  def create
    user=User.find_by(email: params[:session][:email])
    if(user && user.authenticate(params[:session][:password]))
      session[:user_id]=user.id
      flash[:notice]="Logged in successfully"
      redirect_to user_path(user.id)
    else
      flash.now[:alert]="Invalid Email or Password"
      render "new"
    end

  end
  def destroy
    session[:user_id]=nil
    redirect_to root_path
  end
end
