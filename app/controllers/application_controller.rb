class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_cart

  private

  def set_cart
    if user_signed_in? && current_user.cart.nil?
      current_user.create_cart
    end
  end
end
