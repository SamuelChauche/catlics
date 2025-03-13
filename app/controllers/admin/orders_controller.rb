class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @orders = Order.all

    # Filtrer par statut
    if params[:status].present?
      @orders = @orders.where(status: params[:status])
    end

    # Tri par date
    if params[:sort_by] == "date"
      @orders = @orders.order(created_at: :desc)
      @orders = @orders.order(status: :asc)
    end

    start_of_month = Time.now.beginning_of_month
    end_of_month = Time.now.end_of_month
    @total_paid_this_month = Order.where(status: "validated")
                                  .where(created_at: start_of_month..end_of_month)
                                  .sum(:total_price)

    @total_pending = Order.where(status: "pending").sum(:total_price)
  end
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admin_orders_path, notice: "Commande supprimé avec succès."
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Accès non autorisé" unless current_user.admin?
  end
end
