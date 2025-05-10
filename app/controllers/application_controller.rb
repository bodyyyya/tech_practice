class ApplicationController < ActionController::Base
  before_action :set_cart

  private

  def set_cart
    @cart = current_user.cart if user_signed_in?
  end

  def authenticate_user!
    super
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
