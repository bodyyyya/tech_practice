class PropertyValue < ApplicationRecord
  belongs_to :product,  optional: true
  belongs_to :property, optional: true
end
