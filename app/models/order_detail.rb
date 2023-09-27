class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    tax_price * amount
  end
end
