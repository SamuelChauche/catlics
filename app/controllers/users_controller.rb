class UsersController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:item)
    @orders = current_user.orders.includes(cart_items: :item)
    @user = current_user
  end
end
