class SessionsController < ApplicationController
  def new
    
  end

  def create
    # user = User.find_by_email(params[:session][:email].downcase)
    user = User.find_by_email(params[:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    if user && user.authenticate(params[:password])
      signin user
      flash[:success]="#{current_user.name} logged in!" 
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
