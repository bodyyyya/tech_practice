class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @categories = Category.all
    @products = Product.all

    if params[:query].present?
      search_ids = Product.search(
        query: {
          multi_match: {
            query:  params[:query],
            fields: [:title, :description],
            type:   'phrase_prefix'
          }
        }
      ).records.pluck(:id)
  
      @products = @products.where(id: search_ids)
    end
  
    if params[:category_id].present?
      @category   = Category.find(params[:category_id])
      @products   = @products.where(category_id: @category.id)
      @properties = @category.properties.includes(:property_values)
    end

    if params[:filters].present?
      filter_property_ids = params[:filters].keys.map(&:to_i)
      filter_values       = params[:filters].values.flatten
  
      @products = @products
        .joins(:property_values)
        .where(property_values: {
          property_id: filter_property_ids,
          value:       filter_values
        })
        .group('products.id')
        .having('COUNT(DISTINCT property_values.property_id) = ?', filter_property_ids.size)
    end

    if params[:min_price].present? && params[:max_price].present?
      min = params[:min_price].to_i
      max = params[:max_price].to_i
      @products = @products.where(price: min..max)
    elsif params[:min_price].present?
      @products = @products.where('price >= ?', params[:min_price].to_i)
    elsif params[:max_price].present?
      @products = @products.where('price <= ?', params[:max_price].to_i)
    end
  end
  

  def show
  end

  def new
    @product = Product.new
    @categories = Category.all
    @properties = []
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Продукт створено.'
    else
      @categories = Category.all
      @properties = @product.category&.properties || []
      render :new
    end
  end

  def edit
    @categories = Category.all
    @properties = @product.category&.properties || []
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Продукт оновлено.'
    else
      @categories = Category.all
      @properties = @product.category&.properties || []
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to products_url, alert: 'Product could not be destroyed because it has dependent records.'
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :image, :category_id,
      property_values_attributes: [:id, :property_id, :value, :_destroy])
  end

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
  end
end
