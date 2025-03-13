class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :cart_items

  def total_price
    order_items.sum { |item| item.total_price }
  end
end
