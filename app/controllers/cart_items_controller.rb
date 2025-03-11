class CartItemsController < ApplicationController
  def create
    @cart = current_user.cart
    @item_id = Item.find(params[:id])
    @cart_item = @cart.cart_items.create(item: @item_id)
    if @cart_item.save
      redirect_to cart_path(@cart)
    else
      redirect_to items_path
      puts "lajout au panier a echouer *******************************************************************************************************************"
    end
  end

  def update
    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])

    if @cart_item.nil?
      redirect_to cart_path(current_user.cart), alert: "Article non trouvé dans votre panier."
      return
    end
    if params[:cart_item].present? && params[:cart_item][:quantity].present?
      if @cart_item.update(quantity: params[:cart_item][:quantity])
        redirect_to cart_path(current_user.cart), notice: "Quantité mise à jour avec succès."
      else
        redirect_to cart_path(current_user.cart), alert: "Erreur lors de la mise à jour de la quantité."
      end
    else
      redirect_to cart_path(current_user.cart), alert: "Quantité non spécifiée."
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(current_user.cart), notice: "Article retiré du panier"
  end
end
