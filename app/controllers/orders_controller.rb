class OrdersController < ApplicationController
  def show
    # Vérification que la commande existe pour l'utilisateur
    @order = current_user.orders.find(params[:id])
  end
  def index
    @orders = current_user.orders
  end
  def create
    @cart = current_user.cart

    if @cart.cart_items.empty?
      redirect_to cart_path, alert: "Votre panier est vide."
      return
    end

    # Création de la commande
    order = current_user.orders.create(
      status: "pending",
      total_price: @cart.total_price
    )

    if order.persisted?  # Si la commande a bien été sauvegardée
      # Copier les articles du panier vers la commande
      @cart.cart_items.each do |cart_item|
        order.order_items.create(
          item: cart_item.item,
          quantity: cart_item.quantity,
          price: cart_item.item.price
        )
      end

      # # Vider le panier après la création de la commande
      # @cart.cart_items.destroy_all

      # # Redirection vers la page de la commande
      redirect_to order_path(order), notice: "Commande créée avec succès."
    else
      redirect_to cart_path, alert: "Erreur lors de la création de la commande."
    end
  end
end
