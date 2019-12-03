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

ActiveRecord::Schema.define(version: 2019_12_03_163955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "categories_projects", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "project_id"
    t.index ["category_id"], name: "index_categories_projects_on_category_id"
    t.index ["project_id"], name: "index_categories_projects_on_project_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "text", default: "", null: false
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at"
    t.index ["project_id"], name: "index_comments_on_project_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "client_id", null: false
    t.string "client_secret", null: false
    t.string "title", default: "", null: false
    t.bigint "project_id"
    t.index ["project_id"], name: "index_payment_methods_on_project_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.string "address"
    t.string "payment_method", null: false
    t.bigint "project_id"
    t.bigint "user_id"
    t.bigint "amount", default: 0, null: false
    t.index ["project_id"], name: "index_payments_on_project_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "description", default: "", null: false
    t.datetime "end_time"
    t.float "sum_goal", default: 1.0, null: false
    t.float "current_sum", default: 0.0, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.string "payment_secret"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "middle_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "login", default: "", null: false
    t.datetime "birthday", null: false
    t.string "token"
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
