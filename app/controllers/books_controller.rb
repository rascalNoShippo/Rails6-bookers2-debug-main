class BooksController < ApplicationController

  def show
    @users = User.all
    @book = Book.find(params[:id])
    @comment = Comment.new
    unless Visitor.find_by(book_id: @book.id, visitor_id: current_user.id)
      Visitor.create(book_id: @book.id, visitor_id: current_user.id)
    end
  end

  def index
    now = Time.zone.now
    #指定期間のいいねを取得
    favorites = Favorite.where(created_at: (now.days_ago(6).at_beginning_of_day)..(now.at_end_of_day))
    #日時降順でソートし、book_idを配列で取得
    arr = favorites.order(created_at: :DESC).pluck(:book_id)
    #いいねの個数順（配列内で同じ値の個数）降順
    books_searched = Book.find(arr.sort{|a,b| arr.count(b) - arr.count(a)})
    books_remainder = Book.all - books_searched
    @books = books_searched + books_remainder
    @book = Book.new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.viewed_times = 0
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
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

