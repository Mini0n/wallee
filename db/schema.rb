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

ActiveRecord::Schema.define(version: 2019_07_13_001407) do

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "name_on_card"
    t.string "number"
    t.date "expiry"
    t.boolean "debit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comissions", force: :cascade do |t|
    t.decimal "lower_limit"
    t.decimal "upper_limit"
    t.decimal "percentage"
    t.decimal "fixed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "wallet_origin_id"
    t.integer "wallet_destiny_id"
    t.integer "card_origin_id"
    t.integer "card_destiny_id"
    t.decimal "amount"
    t.decimal "percentage"
    t.decimal "fixed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_destiny_id"], name: "index_transactions_on_card_destiny_id"
    t.index ["card_origin_id"], name: "index_transactions_on_card_origin_id"
    t.index ["wallet_destiny_id"], name: "index_transactions_on_wallet_destiny_id"
    t.index ["wallet_origin_id"], name: "index_transactions_on_wallet_origin_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
