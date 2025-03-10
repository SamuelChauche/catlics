class RemoveImageUrlFromItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :items, :image_url, :string
  end
end
