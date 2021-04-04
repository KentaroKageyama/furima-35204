class MessagesController < ApplicationController

  def create
    binding.pry
    @message = Message.new(content: params[:message][:content])
  end
  
end
