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

ActiveRecord::Schema.define(:version => 20130405220208) do

  create_table "admins", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bids", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bids", ["user_id", "job_id", "amount"], :name => "index_bids_on_user_id_and_job_id_and_amount"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "job_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["user_id", "job_id", "content"], :name => "index_comments_on_user_id_and_job_id_and_content"

  create_table "jobphotos", :force => true do |t|
    t.integer  "job_id"
    t.string   "caption"
    t.string   "photo_file_name"
    t.string   "photo_file_type"
    t.integer  "photo_file_size"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "jobphotos", ["job_id"], :name => "index_jobphotos_on_job_id"

  create_table "jobs", :force => true do |t|
    t.integer  "user_id"
    t.text     "title",       :limit => 255
    t.text     "description", :limit => 255
    t.text     "category",    :limit => 255
    t.integer  "current_bid"
    t.integer  "duration"
    t.datetime "expire_date"
    t.boolean  "open",                       :default => true
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "bid_count"
    t.datetime "start_date"
  end

  add_index "jobs", ["user_id", "category", "expire_date"], :name => "index_jobs_on_user_id_and_category_and_expire_date"

  create_table "jobtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "jobtypes", ["name"], :name => "index_jobtypes_on_name"

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.text     "header"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["name"], :name => "index_pages_on_name"

  create_table "pmessages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.string   "title"
    t.string   "body"
    t.datetime "deleted_at"
    t.boolean  "read",        :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "pmessages", ["user_id", "receiver_id"], :name => "index_pmessages_on_user_id_and_receiver_id"

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
    t.string   "facebook_id"
    t.string   "token"
    t.string   "created_by"
    t.string   "role",                     :limit => 25
    t.string   "activation_code",          :limit => 100
    t.datetime "activated_at"
    t.datetime "activation_email_sent_at"
    t.boolean  "admin",                                   :default => false
    t.boolean  "verified",                                :default => false
    t.string   "photo_file_name"
    t.string   "photo_file_type"
    t.integer  "photo_file_size"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.datetime "deleted_at"
    t.string   "membership"
    t.string   "contractor_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["username"], :name => "index_users_on_username"

end
