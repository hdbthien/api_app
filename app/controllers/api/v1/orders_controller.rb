class Api::V1::OrdersController < Api::ApiController
  before_action :set_order, only: :show

  def index
    @orders = @current_user.orders
    api_response @orders
  end

  def show
    api_response @order
  end

  def create
    order = @current_user.orders.build order_params

    if order.save
      render json: order, status: 201
    else
      render json: {errors: order.errors}, status: 422
    end
  end

  private

  def order_params
    params.require(:order).permit :product_ids => []
  end

  def set_order
    return if @order = Order.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound, Message.not_found("order")
  end
end
