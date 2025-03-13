class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @orders = Order.all

    case params[:sort_by]
    when "status"
      @orders = Order.order(status: :asc)
    when "date"
      @orders = Order.order(created_at: :desc)
    when "email"
      @orders = Order.joins(:user).order("users.email ASC") # Assurez-vous que Order appartient à User
    else
      @orders = Order.all
    end
  # Tri par date
  if params[:sort_by] == "date"
  @orders = @orders.order(created_at: :desc)
  @orders = @orders.order(status: :asc)
  end

  # Filtrer par mois et année
  if params[:month].present? && params[:year].present?
    month = Date::MONTHNAMES.index(params[:month])
    year = params[:year].to_i
    start_of_month = Date.new(year, month, 1)
    end_of_month = start_of_month.end_of_month
    @orders = @orders.where(created_at: start_of_month..end_of_month)
  end
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
