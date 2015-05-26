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

ActiveRecord::Schema.define(version: 20150526182957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keywords", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "politicians", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "state"
    t.string   "district"
    t.string   "website"
    t.string   "twitter_handle"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "bioguide_id"
  end

  create_table "user_keywords", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "keyword_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_keywords", ["keyword_id"], name: "index_user_keywords_on_keyword_id", using: :btree
  add_index "user_keywords", ["user_id"], name: "index_user_keywords_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_keywords", "keywords"
  add_foreign_key "user_keywords", "users"
end
