class ConversationsController < ApplicationController
  before_action :require_user_logged_in!

  def index
    @users = User.all
    @pagy, @conversations = pagy(Conversation.all.order(updated_at: :desc))
  end

  def create
    @conversation = Conversation.between(params[:sender_id], params[:recipient_id])
    @conversation = if @conversation.present?
                      @conversation.first
                    else
                      Conversation.create!(conversation_params)
                    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
