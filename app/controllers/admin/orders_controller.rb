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
      @orders = @orders.order(created_at: :desc)  # Tri par date, du plus récent au plus ancien
    elsif params[:sort_by] == "status"
      @orders = @orders.order(status: :asc)  # Tri par statut (en ordre alphabétique par défaut)
    end
  end
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Accès non autorisé" unless current_user.admin?
  end
end
