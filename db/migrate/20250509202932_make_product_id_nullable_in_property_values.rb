class MakeProductIdNullableInPropertyValues < ActiveRecord::Migration[7.1]
  def change
    change_column_null :property_values, :product_id, true
  end
end