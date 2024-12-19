class RenameGamesToProducts < ActiveRecord::Migration[7.1]
  def change
    rename_table :games, :products
  end
end
