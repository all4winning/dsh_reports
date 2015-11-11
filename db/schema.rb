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

ActiveRecord::Schema.define(version: 20151105203352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facebook_posts", force: true do |t|
    t.string   "facebook_id"
    t.text     "picture_link"
    t.text     "link"
    t.text     "name"
    t.datetime "created_time"
    t.string   "facebook_user_id"
    t.integer  "impressions",                 default: 0
    t.integer  "impressions_unique",          default: 0
    t.integer  "impressions_paid_unique",     default: 0
    t.integer  "impressions_paid",            default: 0
    t.integer  "impressions_organic_unique",  default: 0
    t.integer  "impressions_organic",         default: 0
    t.integer  "impressions_viral_unique",    default: 0
    t.integer  "impressions_viral",           default: 0
    t.integer  "impressions_fan_unique",      default: 0
    t.integer  "impressions_fan",             default: 0
    t.integer  "impressions_fan_paid_unique", default: 0
    t.integer  "impressions_fan_paid",        default: 0
    t.integer  "consumptions",                default: 0
    t.integer  "consumptions_unique",         default: 0
    t.integer  "negative_feedback",           default: 0
    t.integer  "negative_feedback_unique",    default: 0
    t.integer  "engaged_fan",                 default: 0
    t.integer  "fan_reach",                   default: 0
    t.integer  "storytellers",                default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wordpress_id"
  end

  create_table "users", force: true do |t|
    t.string   "facebook_email",          default: "",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "profile_image_url"
    t.text     "access_token"
    t.string   "provider"
    t.string   "uid"
    t.datetime "access_token_expires_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "admin",                   default: false
    t.string   "wordpress_user_id"
    t.boolean  "active",                  default: true
  end

  add_index "users", ["facebook_email"], name: "index_users_on_facebook_email", unique: true, using: :btree

  create_table "wordpress_posts", force: true do |t|
    t.integer  "wordpress_id"
    t.text     "title"
    t.text     "name"
    t.datetime "created_time"
    t.integer  "wordpress_user_id"
    t.integer  "sessions",               default: 0
    t.integer  "page_views",             default: 0
    t.integer  "unique_page_views",      default: 0
    t.float    "page_views_per_session", default: 0.0
    t.integer  "average_time_on_page",   default: 0
    t.integer  "users",                  default: 0
    t.float    "page_views_per_user",    default: 0.0
  end

end
