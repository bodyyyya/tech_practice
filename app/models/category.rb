class Category < ApplicationRecord
  has_many :properties, dependent: :destroy
  accepts_nested_attributes_for :properties, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    %w[properties]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end
end
