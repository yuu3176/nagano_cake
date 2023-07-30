class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
    @customer = current_customer
    @orders = @customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def confirm
    @cart_items = CartItem.all
    @total = 0
    @orders = Order.all
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end

  def create
    @order = Order.new(order_params)
    @order.save!
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = cart_item.item.with_tax_price
      @order_detail.order_id = @order.id
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to public_order_finish_path
  end

  def finish
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_payment, :postage, :postal_code, :address, :name)
  end
end
