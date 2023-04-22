class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash[:alert] = "Information not correct"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end
end
