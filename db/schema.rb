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

ActiveRecord::Schema.define(:version => 20130225000019) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "city"
    t.string   "state",                    :limit => 25
    t.string   "zip"
    t.string   "phone"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "reset_code",               :limit => 50
    t.datetime "reset_code_at"
    t.string   "role",                     :limit => 25
    t.string   "activation_code",          :limit => 100
    t.datetime "activated_at"
    t.datetime "activation_email_sent_at"
    t.boolean  "admin",                                   :default => false
    t.boolean  "verified",                                :default => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.string   "facebook_id"
    t.string   "token"
    t.string   "created_by"
    t.string   "photo_file_name"
    t.string   "photo_file_type"
    t.integer  "photo_file_size"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

end