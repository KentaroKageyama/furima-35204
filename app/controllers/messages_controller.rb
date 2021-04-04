class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @user = User.find(@message.user_id)
    @item = Item.find(@message.item_id)
    if @message.save
      ActionCable.server.broadcast 'message_channel', message: @message, user: @user, item: @item
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id, item_id: params[:item_id])
  end

end
