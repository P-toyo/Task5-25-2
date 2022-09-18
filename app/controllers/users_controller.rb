class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @post_books = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to edit_user_path
  end

  def index
    @user = current_user
    @users = User.all
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
