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

ActiveRecord::Schema.define(version: 20130506080701) do

  create_table "parents", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "addr"
    t.string   "city"
    t.string   "state"
    t.integer  "zip",        limit: 12
    t.integer  "reg_method", limit: 1
    t.boolean  "confirmed?",            default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "phone_id"
  end

  add_index "parents", ["phone_id"], name: "index_parents_on_phone_id"
  add_index "parents", ["reg_method"], name: "index_parents_on_reg_method"

  create_table "phones", force: true do |t|
    t.integer  "parent_id"
    t.string   "number"
    t.integer  "phone_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["parent_id"], name: "index_phones_on_parent_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin",           default: false, null: false
    t.string   "session_token"
    t.string   "username"
    t.integer  "privileges",      default: 0,     null: false
  end

  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
