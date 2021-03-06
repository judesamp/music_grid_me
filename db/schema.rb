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

ActiveRecord::Schema.define(version: 20140607211952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_likes", force: true do |t|
    t.integer "user_id"
    t.integer "album_id"
    t.text    "user_comment"
    t.integer "rating"
  end

  create_table "albums", force: true do |t|
    t.string "title"
    t.string "band"
    t.date   "release"
  end

  create_table "taste_profiles", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "echonest_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_token"
    t.string   "user_token"
  end

end
