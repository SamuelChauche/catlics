class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = current_user
    @total = params[:total].to_d
    @event_id = params[:event_id]
    @session = Stripe::Checkout::Session.create(
      payment_method_types: [ "card" ],
      line_items: [
        {
          price_data: {
            currency: "eur",
            unit_amount: (@total*100).to_i,
            product_data: {
              name: "Rails Stripe Checkout"
            }
          },
          quantity: 1
        }
      ],
      mode: "payment",
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url+ "?session_id={CHECKOUT_SESSION_ID}",
      metadata: {
        event_id: @event_id, session_id: @session
      },
      )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @event_id = @session.metadata.event_id
    
    order=Order.find(@event_id)

    if order && order.status == "pending"
      order.update(status: "validated")
      # Vous pouvez ajouter des actions supplémentaires ici si nécessaire
    end

    UserMailer.order_email(order).deliver_now
  end

  def cancel
    @order = current_user.orders.find_by(id: @event_id)
    if @order && @order.status == "pending"
      @order.update(status: "cancelled")
      @order.destroy_all
    end
    redirect_to checkout_cancel_url, allow_other_host: true
  end
end
