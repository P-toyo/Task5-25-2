class BooksController < ApplicationController
  def index
    @user = current_user
    @books = Book.all
    @post_book = Book.new
  end

  def create
    @post_book = Book.new(book_params)
    @post_book.user_id = current_user.id
    @post_book.save
    redirect_to books_path(current_user.id)
  end

  def show
    @book = Book.find(params[:id])
    @user = current_user
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
