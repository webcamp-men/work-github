class Public::CartItemsController < ApplicationController
  def index
    @customer = current_customer
    @cart_item = CartItem.new
    @cart_items = CartItem.all
    @item = Item.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
end
