class CategoriesController < ApplicationController
  def properties_form
    @category   = Category.find(params[:id])
    @properties = @category.properties.includes(:property_values)
    @product    = params[:product_id].present? ?
                    Product.find(params[:product_id]) :
                    Product.new

    render partial: "products/property_fields",
           locals: { product: @product, properties: @properties }
  end
end
