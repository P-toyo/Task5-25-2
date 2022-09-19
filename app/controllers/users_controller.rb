class UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @post_book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id

    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @users = User.all
    @post_book = Book.new
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
