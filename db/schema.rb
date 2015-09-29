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

ActiveRecord::Schema.define(version: 20150926160254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "meta_id"
    t.string   "meta_type"
    t.string   "stripe_account_id"
    t.string   "stripe_subscription_id"
  end

  add_index "accounts", ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true, using: :btree
  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["meta_id", "meta_type"], name: "index_accounts_on_meta_id_and_meta_type", using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["stripe_account_id"], name: "index_accounts_on_stripe_account_id", using: :btree
  add_index "accounts", ["stripe_subscription_id"], name: "index_accounts_on_stripe_subscription_id", using: :btree
  add_index "accounts", ["unlock_token"], name: "index_accounts_on_unlock_token", unique: true, using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role",                   default: 0
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "ambassadors", force: :cascade do |t|
    t.string   "email",              default: ""
    t.string   "phone",              default: ""
    t.string   "fname",              default: ""
    t.string   "lname",              default: ""
    t.date     "dob"
    t.string   "street",             default: ""
    t.string   "city",               default: ""
    t.string   "state",              default: ""
    t.string   "zip",                default: ""
    t.string   "token"
    t.string   "registration_token"
    t.integer  "status"
    t.integer  "parent_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "referred_via"
  end

  add_index "ambassadors", ["parent_id"], name: "index_ambassadors_on_parent_id", using: :btree
  add_index "ambassadors", ["registration_token"], name: "index_ambassadors_on_registration_token", unique: true, using: :btree
  add_index "ambassadors", ["token"], name: "index_ambassadors_on_token", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "expositions", force: :cascade do |t|
    t.datetime "when"
    t.decimal  "point_spread"
    t.string   "stream_url"
    t.integer  "home_id"
    t.integer  "away_id"
    t.integer  "week_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "expositions", ["away_id"], name: "index_expositions_on_away_id", using: :btree
  add_index "expositions", ["home_id"], name: "index_expositions_on_home_id", using: :btree
  add_index "expositions", ["week_id"], name: "index_expositions_on_week_id", using: :btree

  create_table "payout_matrices", force: :cascade do |t|
    t.integer  "generation"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payout_matrices", ["generation"], name: "index_payout_matrices_on_generation", unique: true, using: :btree

  create_table "picks", force: :cascade do |t|
    t.integer  "exposition_id"
    t.integer  "account_id"
    t.boolean  "choice"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "picks", ["account_id"], name: "index_picks_on_account_id", using: :btree
  add_index "picks", ["exposition_id"], name: "index_picks_on_exposition_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "conference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "number"
    t.datetime "deadline"
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expositions", "weeks"
  add_foreign_key "picks", "accounts"
  add_foreign_key "picks", "expositions"
end
