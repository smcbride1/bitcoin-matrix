class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :wallet_id
      t.string :order_type
      t.string :amount
      t.string :price
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
