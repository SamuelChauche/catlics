class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def price_sum
    self.item.price * self.quantity
  end
end
