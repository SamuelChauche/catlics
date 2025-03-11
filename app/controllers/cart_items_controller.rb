class CartItemsController < ApplicationController
  def create
    @cart = current_user.cart
    @item_id = Item.find(params[:id])

    @cart_item = @cart.cart_items.create(item: @item_id)
    if @cart_item.save
      redirect_to cart_path(@cart)
    else
      redirect_to items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(current_user.cart), notice: "Article retiré du panier"
  end
end
