class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = if params[:query].present?
               Product.search(query: {
                 multi_match: {
                   query: params[:query],
                   fields: [:title, :description],
                   type: 'phrase_prefix'
                 }
               }).records.to_a
             else
               Product.all
             end

    if params[:min_price].present? && params[:max_price].present?
      min_price = params[:min_price].to_i
      max_price = params[:max_price].to_i
      @products = @products.where(price: min_price..max_price)
    elsif params[:min_price].present?
      min_price = params[:min_price].to_i
      @products = @products.where('price >= ?', min_price)
    elsif params[:max_price].present?
      max_price = params[:max_price].to_i
      @products = @products.where('price <= ?', max_price)
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
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
    params.require(:product).permit(:title, :description, :price, :image)
  end

  def authorize_admin!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.admin?
  end
end
