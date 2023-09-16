# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_09_16_105345) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.text "descripton"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_invitations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.boolean "leader", default: false
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_invitations_on_group_id"
    t.index ["user_id"], name: "index_group_invitations_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.bigint "restorant_id"
    t.integer "week", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restorant_id"], name: "index_groups_on_restorant_id"
  end

  create_table "restorants", force: :cascade do |t|
    t.string "name", null: false
    t.text "descripton"
    t.string "phone"
    t.string "address_street"
    t.string "address_number"
    t.string "address_postcode"
    t.string "address_town"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "department_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "group_invitations", "groups"
  add_foreign_key "group_invitations", "users"
  add_foreign_key "groups", "restorants"
  add_foreign_key "users", "departments"
end
