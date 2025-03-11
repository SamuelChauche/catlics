class UsersController < ApplicationController
  def show
    # @orders = current_user.orders
    @user = current_user
    # @past_order_images = @user.orders.order_items.item.image
    @images = @user.orders.includes(order_items: :item).map { |order| order.order_items.map { |order_item| order_item.item.image } }.flatten

    @orders = @user.orders

  end
end
