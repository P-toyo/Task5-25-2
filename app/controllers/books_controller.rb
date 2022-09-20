class BooksController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    @books = Book.all
    @post_book = Book.new
  end

  def create
    @user = current_user
    @post_book = Book.new(book_params)
    @post_book.user_id = current_user.id
    if @post_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post_book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @post_book = Book.new
    @posted_book = Book.find(params[:id])
    @post_user = User.find(@posted_book.user_id)
    @user = current_user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
