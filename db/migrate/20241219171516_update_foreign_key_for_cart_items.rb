class UpdateForeignKeyForCartItems < ActiveRecord::Migration[7.1]
  def change
    # Remove the old foreign key only if it exists
    if foreign_key_exists?(:cart_items, column: :game_id)
      remove_foreign_key :cart_items, column: :game_id
    end

    # Add the new foreign key for product_id
    add_foreign_key :cart_items, :products, column: :product_id
  end
end
