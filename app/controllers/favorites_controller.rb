class FavoritesController < ApplicationController

  def create
    favorite = current_user.favorites.build(item_id: params[:item_id])
    favorite.save
    redirect_to item_path(params[:item_id])
  end

  def destroy
    favorite = Favorite.find_by(item_id: params[:item_id], user_id: current_user.id)
    favorite.destroy
    redirect_to item_path(params[:item_id])
  end

end
