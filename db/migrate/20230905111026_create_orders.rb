class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :shipping_postal_code, null: false
      t.string :shipping_adddress, null: false
      t.string :delivery_name, null: false
      t.integer :method_of_payment, null: false
      t.integer :payment_amount, null: false
      t.integer :postage, null: false
      t.timestamps
    end
  end
end
