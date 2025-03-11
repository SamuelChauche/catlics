class UsersController < ApplicationController
  def show
    # @orders = current_user.orders
    @user = current_user
  end
end
