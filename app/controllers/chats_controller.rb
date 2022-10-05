class ChatsController < ApplicationController
  def index
    @chat = Chat.new
    @chats = Chat.where(sender_id: current_user.id, receiver_id: params[:user_id]).or(Chat.where(sender_id: params[:user_id], receiver_id: current_user.id))
    @book = Book.new
    @user = User.find(params[:user_id])
  end

  def create
    @chats = Chat.where(sender_id: current_user.id, receiver_id: params[:user_id]).or(Chat.where(sender_id: params[:user_id], receiver_id: current_user.id))
    @chat = current_user.chats_sent.new(chat_params)
    @chat.receiver_id = params[:user_id]
    @user = User.find(params[:user_id])
    if !@user.following(current_user).nil? && !@user.follower(current_user).nil?
      if @chat.save
        redirect_to user_chats_path
      else
        render :index
      end
    else
      redirect_to user_chats_path
    end
    @book = Book.new
  end

  private

  def chat_params
    params.require(:chat).permit(:body)
  end
end
