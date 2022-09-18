class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.book_id =  @book.id
    @users = User.all
    #if @comment.save
    #  redirect_back(fallback_location: book_path(@book.id))
    #else
    #  render "books/show"
    #end
    @comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @users = User.all
    comment = Comment.find(params[:id])
    comment.destroy
    #redirect_back(fallback_location: book_path(book.id))
  end

  def comment_params
    params.require(:comment).permit(:comment_body)
  end

end
