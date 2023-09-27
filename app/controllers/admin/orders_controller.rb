class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @item = Item.find(params[:id])
    @order_details = @order.order_details.all
  end
end
