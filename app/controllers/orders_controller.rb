class OrdersController < ApplicationController
  def create
    @cart = current_user.cart

    if cart.cart_items.empty?
      redirect_to cart_path, alert: "Votre panier est vide."
      return
    end

    order = current_user.orders.create(
      status: "pending",
      total: @cart.total_price
    )

    # Copier les articles du panier vers la commande
    cart.cart_items.each do |cart_item|
      order.order_items.create(
        product: cart_item.item,
        quantity: cart_item.quantity,
        price: @cart.total_price
      )
    end

    if @order.save
      @cart.cart_items.destroy_all # Vider le panier après la création de la commande
      redirect_to order_path(@order), notice: "Commande créée avec succès."
    else
      redirect_to cart_path, alert: "Erreur lors de la création de la commande."
    end
    redirect_to order_path(order), notice: "Commande passée avec succès !"
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
