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
    if [@conversation.sender_id, @conversation.receiver_id].include?(current_user.id)
      @messages = @conversation.direct_messages
      @message = DirectMessage.new
    else
      redirect_to conversations_path, alert: 'Unauthorized access'
    end
  end
end
