class CategoriesController < ApplicationController
  def properties_form
    @category = Category.find(params[:id])
    @properties = @category.properties
    @product = Product.new
    render partial: "products/property_fields", locals: { product: @product }
  end
end
