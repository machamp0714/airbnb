class MessagesController < ApplicationController
  before_action :authenticate_user

  def index
    @conversation = Conversation.find(params[:conversation_id])
    if current_user == @conversation.sender || current_user == @conversation.recipient
      @other = current_user == @conversation.sender ? @conversation.recipient : @conversation.sender
      @messages = @conversation.messages.order(created_at: :desc)
    else
      redirect_to conversations_path, alert: "You don't have a permisiion to view this."
    end
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @messages = @conversation.messages.order(created_at: :desc)

    if @message.save
      redirect_to conversations_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:content, :user_id)
    end
end
