class Item < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  has_many :cart_items
  has_many :carts, through: :cart_items

  has_many :order_items
  has_many :order, through: :cart_items

  belongs_to :breed

end
