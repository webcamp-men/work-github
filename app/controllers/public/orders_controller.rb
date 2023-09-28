class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @customer = current_customer
    @order = Order.new
    @address = current_customer.address
  end

  def confirm
    @customer = current_customer
    @order = Order.new(order_params)
    @order.shipping_postal_code = current_customer.postal_code
    @order.shipping_adddress = current_customer.address
    @order.delivery_name = current_customer.last_name + current_customer.first_name
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.tax_price = (cart_item.item.price*1.1).floor
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to complete_orders_path
  end

  def complete
    @customer = current_customer
  end

  def index
    @customer = current_customer
    @orders = current_customer.orders.all

  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :shipping_postal_code, :shipping_adddress, :delivery_name, :method_of_payment, :payment_amount, :postage)
  end
end
