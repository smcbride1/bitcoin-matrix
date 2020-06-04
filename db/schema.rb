# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200602225523) do

  create_table "transactions", force: :cascade do |t|
    t.integer  "wallet_id"
    t.string   "order_type"
    t.decimal  "amount"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "restriction_type"
    t.decimal  "btc_balance"
    t.decimal  "usd_balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
