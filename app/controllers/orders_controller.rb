class OrdersController < ApplicationController
 
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_address = OrderShippingAddress.new 
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:donation_address).permit(:item_id, :zip_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id)
  end

end
