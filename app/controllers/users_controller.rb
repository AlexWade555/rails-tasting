class UsersController < ApplicationController
  before_action :set_user, only: :index
  # dashboard
  def index
    @user = policy_scope(current_user)
    @products_ids = @user.product_ids
    @products = Product.find(@products_ids)
  end

  private

  def set_user
    @user = current_user
  end
end
