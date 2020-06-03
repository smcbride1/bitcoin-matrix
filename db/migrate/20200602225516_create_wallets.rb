class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.string :name
      t.string :restriction_type
      t.string :btc_balance
      t.string :usd_balance
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
