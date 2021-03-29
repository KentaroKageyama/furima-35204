class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :another_user_move_to_index, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_id, :shipping_add_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def another_user_move_to_index
    set_item
    redirect_to action: :index if current_user.id != @item.user.id
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
