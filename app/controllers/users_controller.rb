class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    now = Time.zone.now
    @posts_today = @books.count{|x| (now.at_beginning_of_day..now.at_end_of_day).cover?(x.created_at)}
    @posts_yesterday = @books.count{|x| (now.yesterday.at_beginning_of_day..now.yesterday.at_end_of_day).cover?(x.created_at)}
    @posts_this_week = @books.count{|x| (now.days_ago(6).at_beginning_of_day..now.at_end_of_day).cover?(x.created_at)}
    @posts_last_week = @books.count{|x| (now.days_ago(13).at_beginning_of_day..now.days_ago(7).at_end_of_day).cover?(x.created_at)}
    
  end

  def date
    user = User.find(params[:user_id])
    period = params[:date].to_date.all_day
    @num_books = user.books.count{|x| period.cover?(x.created_at)}
    render "dateviewer"
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
