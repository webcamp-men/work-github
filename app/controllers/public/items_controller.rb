class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @customer = current_customer
    @items = Item.page(params[:page])
  end

  def show
    @customer = current_customer
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
