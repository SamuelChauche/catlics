class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :items, through: :cart_items

  def total_price
    cart_items.sum { |item| item.item.price }
  end
end
