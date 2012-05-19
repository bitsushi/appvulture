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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120518111434) do

  create_table "apps", :force => true do |t|
    t.string   "name",          :limit => 100
    t.string   "mid",           :limit => 40
    t.decimal  "price",                        :precision => 6, :scale => 2, :default => 0.0
    t.string   "currency",      :limit => 3,                                 :default => "GBP"
    t.decimal  "high",                         :precision => 6, :scale => 2, :default => 0.0
    t.decimal  "low",                          :precision => 6, :scale => 2, :default => 0.0
    t.string   "icon"
    t.string   "type",          :limit => 7
    t.integer  "watcher_count",                                              :default => 0
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
  end

  add_index "apps", ["id", "type"], :name => "index_apps_on_id_and_type"
  add_index "apps", ["mid"], :name => "index_apps_on_mid"
  add_index "apps", ["name"], :name => "index_apps_on_name"

  create_table "changes", :force => true do |t|
    t.integer  "app_id"
    t.decimal  "price",  :precision => 6, :scale => 2, :default => 0.0
    t.datetime "at"
  end

  add_index "changes", ["app_id"], :name => "index_changes_on_app_id"

  create_table "lenses", :force => true do |t|
    t.integer  "watcher_id"
    t.integer  "app_id"
    t.integer  "rule",          :limit => 2,                               :default => 0
    t.decimal  "initial_price",              :precision => 6, :scale => 2, :default => 0.0
    t.decimal  "desired_price",              :precision => 6, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                :null => false
    t.datetime "updated_at",                                                                :null => false
  end

  add_index "lenses", ["app_id", "watcher_id"], :name => "index_lenses_on_app_id_and_watcher_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :limit => 100
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "state",                  :limit => 20
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "users", ["auth_token"], :name => "index_users_on_auth_token"
  add_index "users", ["email"], :name => "index_users_on_email"

end
