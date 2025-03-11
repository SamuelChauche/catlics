class CartsController < ApplicationController
  before_action :set_cart

  def show
    puts "@cart est : #{@cart.inspect}"
    @cart_items = @cart.cart_items.includes(:item)
    @total_price = @cart.total_price
  end

  def add_item
    @item = Item.find(params[:item_id])
    cart_item = @cart.cart_items.find_by(item: @item)

    if cart_item
      cart_item.increment(:quantity)
      cart_item.save
      flash[:notice] = "Cet item est déjà dans votre panier. Nous avons rajoutez un item suplémentaire"
      puts " #{cart_item.inspect} DEJA DANS LE PANIER ***************************************************************************************************** "
    else
      cart_item = @cart.cart_items.create(item: @item, quantity: 1)
      @cart.cart_items.create(item: @item)
      flash[:notice] = "Item ajouté au panier avec succès."
      puts "L'article #{@item.id} a été ajouté au panier #{@cart.id} SUCCEED ############################################################################## "
    end
    redirect_to cart_path
  end

  def destroy
    @cart.cart_items.destroy_all
    redirect_to cart_path, notice: "Panier vidé."
  end


  private

  def set_cart
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour ajouter un article au panier."
    end
  end
end
