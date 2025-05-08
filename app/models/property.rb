class Property < ApplicationRecord
  belongs_to :category
  has_many :property_values
  serialize :options, coder: JSON
end
