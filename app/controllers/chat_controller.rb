class ChatController < ApplicationController
  def index
    session[:conversations] ||= []
    
    # select all users except logged in users
    @users = User.all.where.not(id: current_user)
    # select all conversations
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end
end
