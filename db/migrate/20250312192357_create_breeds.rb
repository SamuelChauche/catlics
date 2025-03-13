class CreateBreeds < ActiveRecord::Migration[8.0]
  def change
    create_table :breeds do |t|
      t.string :name
      t.string :string

      t.timestamps
    end
  end
end
