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

ActiveRecord::Schema.define(version: 20160407211007) do

  create_table "bids", force: :cascade do |t|
    t.decimal  "amount",     precision: 8, scale: 2, null: false
    t.integer  "user_id",                            null: false
    t.integer  "product_id",                         null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "unit",                               null: false
  end

  add_index "bids", ["product_id"], name: "index_bids_on_product_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "photo",          null: false
    t.integer  "price",          null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "highest_bidder"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
