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

ActiveRecord::Schema.define(version: 20130510035649) do

  create_table "children", force: true do |t|
    t.integer  "parent_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["parent_id"], name: "index_children_on_parent_id"

  create_table "delegations", force: true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.boolean  "status",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delegations", ["user_id"], name: "index_delegations_on_user_id"

  create_table "parents", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title",                       default: "none"
    t.string   "email"
    t.string   "addr"
    t.string   "city"
    t.string   "state"
    t.integer  "zip",              limit: 12
    t.integer  "reg_method",       limit: 1
    t.integer  "confirmed_status",            default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "tour_date"
  end

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
