class AddOptionsToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :options, :text
  end
end
