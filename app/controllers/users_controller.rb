class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]
  def index
    @users = User.paginate(page: params[:page], per_page: 2)

  end
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end
  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "Yor account has been updated"
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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

  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    unless current_user == @user
      flash[:alert] = "You can not do this action"
      redirect_to @user
    end
  end
end
