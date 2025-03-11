class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :cart_items
  def 

  enum :status, [:pending, :paid, :cancelled, :shipped, :delivered], default: :pending
end

