class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true

  before_create :set_price

  def total_price
    (price || product.price) * quantity
  end

  private

  def set_price
    self.price ||= product.price
  end
end
