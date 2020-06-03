class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :wallet_id
      t.string :type
      t.string :amount
      t.string :price
    end
  end
end
