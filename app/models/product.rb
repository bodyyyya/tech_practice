class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_one_attached :image
  belongs_to :category, optional: true
  has_many :property_values
  has_many :properties, through: :property_values
  has_many :cart_items, dependent: :destroy
  accepts_nested_attributes_for :property_values, allow_destroy: true

  settings index: {
    analysis: {
      analyzer: {
        default: {
          type: 'standard'
        }
      }
    }
  } do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: 'standard'
      indexes :description, type: :text, analyzer: 'standard'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:title, :description])
  end
end

# Ensure the index is created and data is imported
Product.__elasticsearch__.create_index! force: true
Product.import
