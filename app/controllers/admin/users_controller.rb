class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [ :index, :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @images = @user.orders.includes(order_items: :item).map { |order| order.order_items.map { |order_item| order_item.item.image } }.flatten
    @orders = @user.orders
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "Utilisateur mis à jour avec succès."
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "Utilisateur supprimé avec succès."
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Accès non autorisé" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
