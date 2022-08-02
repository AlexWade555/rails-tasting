class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_product, only:[:show, :edit, :update, :destroy]
  def index
    if params[:query].present?
      @products = policy_scope(Product).search_by_title_and_description_and_category(params[:query])
    else
      @products = policy_scope(Product)
    end
    respond_to do |format|
      format.html
      format.json { render json: { products: @products } }
    end
  end

  def show
    # @session = Session.new(product: @product)
  end

  def new
    @product = current_user.products.new
    authorize @product
  end

  def create
    @product = current_user.products.new(product_params)
    # @product.user = current_user
    authorize @product
    if @product.save
      redirect_to product_path(@product), notice: 'Your product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to root_path, notice: 'product was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'product was successfully deleted'
  end

  private

  def set_product
    @product = Product.find(params[:id])
    authorize @product
  end

  def product_params
    params.require(:product).permit(:title, :category, :rating, :user_id, :photo, :price, :description)
  end
end
