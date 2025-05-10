class Property < ApplicationRecord
  belongs_to :category
  has_many   :property_values, dependent: :destroy

  serialize :options, JSON
  accepts_nested_attributes_for :property_values, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    %w[category property_values]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name category_id options created_at updated_at]
  end
end
