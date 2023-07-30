class Admin::OrderDetailsController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount)
  end
