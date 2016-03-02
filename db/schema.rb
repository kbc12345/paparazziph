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

ActiveRecord::Schema.define(version: 20160301150818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "cover_photo"
    t.string "layout",      default: "horizontal"
    t.string "category",    default: "photoman"
    t.date   "created_at"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "category"
    t.string "rate"
    t.string "client_name"
    t.string "client_email"
    t.string "client_number"
    t.string "event_title"
    t.string "date"
    t.string "start_time"
    t.string "venue"
    t.text   "comment"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "url"
    t.integer  "album_id"
    t.datetime "created_at"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobile"
    t.text   "message"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.string  "reviewer"
    t.text    "message"
  end

end
