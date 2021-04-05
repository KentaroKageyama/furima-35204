class FavoritesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    favorite = current_user.favorites.build(item_id: params[:item_id])
    favorite.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    favorite.destroy
  end
end
