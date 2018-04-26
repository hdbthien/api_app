class Api::V1::ProductsController < Api::ApiController
  before_action :authenticate_admin, only: %i(create update destroy)
  before_action :set_product, only: %i(show update destroy)


  def index
    @products = Product.all
    api_response @products
  end

  def show
    api_response @product
  end

  def create
    product = Product.new product_params

    if product.save
      render json: product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update product_params
      render json: @product, status: :no_content
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    api_response({message: "Remove product success"}, :no_content)
  end

  private

  def set_product
    return if @product = Product.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound, Message.not_found("product")
  end

  def product_params
    params.require(:product).permit(:name, :brand, :price)
  end

  def authenticate_admin
    return if @current_user.admin?
    api_response({message: Message.dont_have_permission}, :forbidden)
  end
end
