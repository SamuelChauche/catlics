class CartsController < ApplicationController
  def index
  end

  def show
    @cart=current_user.cart
  end

  def new
  end

  def create
  end

  def edit
    before_action :authenticate_user!
    @item = Item.find(params[:id])
    current_user.cart.(@item)
    redirect_to cart_path, notice: "Article ajouté au panier"
  end

  def update
  end

  def destroy
  end
end
