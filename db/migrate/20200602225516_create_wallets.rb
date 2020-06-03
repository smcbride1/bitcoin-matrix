class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.string :btc_balance
      t.string :usd_balance
    end
  end
end
