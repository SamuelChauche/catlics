class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def total_price
    item.price * quantity
  end
end
