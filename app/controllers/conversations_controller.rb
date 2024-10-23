class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where(sender_id: current_user.id)
                      .or(Conversation.where(receiver_id: current_user.id))
  end

  def create
    @conversation = Conversation.between(current_user.id, params[:receiver_id]).first
    if @conversation.nil?
      @conversation = Conversation.create(sender_id: current_user.id, receiver_id: params[:receiver_id])
    end
    redirect_to conversation_path(@conversation)
  end

  def show
    @conversation = Conversation.find(params[:id])
    
    can_access = (current_user.following?(@conversation.sender) && @conversation.sender.present?) ||
                 (current_user.following?(@conversation.receiver) && @conversation.receiver.present?)
    
    Rails.logger.info "User #{current_user.id} trying to access conversation #{@conversation.id}. Can access: #{can_access}"
    
    unless can_access
      redirect_to users_posts_path, alert: 'このユーザーとはチャットできません。'
      return
    end
    
    @messages = @conversation.direct_messages
    @message = DirectMessage.new
    Rails.logger.info "Messages loaded for conversation #{@conversation.id}: #{@messages.count} messages."
  end

end
