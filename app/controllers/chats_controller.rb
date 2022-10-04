class ChatsController < ApplicationController
  def index
    @chat = Chat.new
    @chats = Chat.where(sender_id: current_user.id, receiver_id: params[:user_id]).or(Chat.where(sender_id: params[:user_id], receiver_id: current_user.id))

  end

  def create
    @chats = Chat.where(sender_id: current_user.id, receiver_id: params[:user_id]).or(Chat.where(sender_id: params[:user_id], receiver_id: current_user.id))
    @chat = current_user.chats_sent.new(chat_params)
    @chat.receiver_id = params[:user_id]
    if @chat.save
      redirect_to user_chats_path
    else
      render :index
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:body)
  end
end
