class AddQuantityToCartItems < ActiveRecord::Migration[8.0]
  def change
    add_column :cart_items, :quantity, :integer
  end
end
