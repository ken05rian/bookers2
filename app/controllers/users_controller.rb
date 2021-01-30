class UsersController < ApplicationController

  before_action :confirm_user,only: [:edit, :update]


  def confirm_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  def create
    @user = User.new
    if @user.save
      flash[:notice] ="You have created user successfully."
      redirect_to user_path(@user.id)
    else
      render template: 'users/index'
    end
  end

 private

 def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
 end

end