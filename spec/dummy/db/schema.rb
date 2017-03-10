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

ActiveRecord::Schema.define(version: 20170309145901) do

  create_table "payful_memberships", force: :cascade do |t|
    t.integer  "payful_service_id"
    t.integer  "memberable_id"
    t.string   "memberable_type"
    t.boolean  "active"
    t.integer  "base_price_in_cents"
    t.integer  "base_price_days"
    t.datetime "expires_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "payful_memberships", ["active"], name: "index_payful_memberships_on_active"
  add_index "payful_memberships", ["memberable_id", "memberable_type"], name: "index_payful_memberships_on_memberable_id_and_memberable_type"
  add_index "payful_memberships", ["payful_service_id"], name: "index_payful_memberships_on_payful_service_id"

  create_table "payful_memberships_transactions", id: false, force: :cascade do |t|
    t.integer "membership_id",  null: false
    t.integer "transaction_id", null: false
  end

  add_index "payful_memberships_transactions", ["membership_id"], name: "index_payful_memberships_transactions_on_membership_id"
  add_index "payful_memberships_transactions", ["transaction_id"], name: "index_payful_memberships_transactions_on_transaction_id"

  create_table "payful_service_pricings", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "period_in_days"
    t.integer  "amount_in_cents"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "payful_service_pricings", ["service_id"], name: "index_payful_service_pricings_on_service_id"

  create_table "payful_services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payful_transactions", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "state",                                       null: false
    t.datetime "completed_at"
    t.integer  "extends_memberships_for_days"
    t.text     "metadata_json",                default: "{}"
    t.integer  "amount_in_cents",                             null: false
    t.string   "payment_type"
    t.string   "payment_url"
    t.string   "payment_remote_id"
    t.datetime "payment_emailed_at"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "payful_transactions", ["owner_type", "owner_id"], name: "payful_txn_owner_type_id"
  add_index "payful_transactions", ["payment_remote_id"], name: "index_payful_transactions_on_payment_remote_id"
  add_index "payful_transactions", ["state"], name: "index_payful_transactions_on_state"

  create_table "payful_webhooks", force: :cascade do |t|
    t.integer  "hookable_id"
    t.string   "hookable_type"
    t.string   "state",               null: false
    t.datetime "failed_at"
    t.datetime "processed_at"
    t.string   "source"
    t.string   "source_reference_id"
    t.string   "event"
    t.text     "data_json"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "payful_webhooks", ["hookable_id", "hookable_type"], name: "index_payful_webhooks_on_hookable_id_and_hookable_type"
  add_index "payful_webhooks", ["source_reference_id"], name: "index_payful_webhooks_on_source_reference_id"
  add_index "payful_webhooks", ["state"], name: "index_payful_webhooks_on_state"

end
