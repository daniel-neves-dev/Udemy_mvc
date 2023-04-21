class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @articles = @user.articles

  end
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Yor account has been updated"
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to Alpha Blog #{@user.name}"
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
