class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true

  before_create :set_price

  def generated_keys
    JSON.parse(self[:generated_keys] || '[]')
  end

  def generated_keys=(keys)
    self[:generated_keys] = keys.to_json
  end

  def total_price
    (price || product.price) * quantity
  end

  private

  def set_price
    self.price ||= product.price
  end
end
