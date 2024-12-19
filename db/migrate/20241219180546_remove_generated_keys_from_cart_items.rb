class RemoveGeneratedKeysFromCartItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :cart_items, :generated_key, :string
    remove_column :cart_items, :generated_keys, :text
  end
end
