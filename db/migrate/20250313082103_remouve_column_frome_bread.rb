class RemouveColumnFromeBread < ActiveRecord::Migration[8.0]
  def change
    remove_column :breeds, :string, :string

  end
end
