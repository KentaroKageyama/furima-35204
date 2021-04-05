class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @user = User.find(@message.user_id)
    @item = Item.find(@message.item_id)
    ActionCable.server.broadcast 'message_channel', message: @message, user: @user, item: @item if @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
