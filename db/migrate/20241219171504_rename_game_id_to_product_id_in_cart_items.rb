class RenameGameIdToProductIdInCartItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :cart_items, :game_id, :product_id
  end
end