# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_16_145457) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_references", force: :cascade do |t|
    t.integer "category", null: false
    t.integer "user", null: false
    t.string "path", limit: 190, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category", "updated_at"], name: "index_file_references_on_category_and_updated_at"
    t.index ["category", "user", "path"], name: "index_file_references_category_and_user_and_path"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", limit: 100
    t.string "first_name", limit: 100, null: false
    t.string "second_name", limit: 100
    t.string "last_name", limit: 100
    t.string "contact_number", limit: 40
    t.string "building_name", limit: 40
    t.string "address_line_1", limit: 40
    t.string "address_line_2", limit: 40
    t.string "city", limit: 40
    t.string "country", limit: 30
    t.string "postcode", limit: 15
    t.string "email", limit: 30, null: false
    t.string "role", default: "0"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
  end

end
