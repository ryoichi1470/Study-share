class DirectMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  def create
    @message = @conversation.direct_messages.build(message_params)
    @message.sender_id = current_user.id
    if @message.save
      redirect_to conversation_path(@conversation)
    else
      flash[:alert] = 'メッセージが送信できませんでした'
      render 'conversations/show'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:direct_message).permit(:body)
  end
end
