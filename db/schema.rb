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

ActiveRecord::Schema.define(version: 2021_09_14_095933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.string "email"
    t.string "adress"
    t.string "city"
    t.string "phone"
    t.integer "zip_code"
    t.integer "logo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_schools_on_name"
  end

  create_table "super_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "school_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", limit: 25, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.integer "status", default: 1
    t.index ["email"], name: "index_super_admins_on_email", unique: true
    t.index ["invitation_token"], name: "index_super_admins_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_super_admins_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_super_admins_on_invited_by"
    t.index ["reset_password_token"], name: "index_super_admins_on_reset_password_token", unique: true
  end

  create_table "super_admins_roles", id: false, force: :cascade do |t|
    t.bigint "super_admin_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_super_admins_roles_on_role_id"
    t.index ["super_admin_id", "role_id"], name: "index_super_admins_roles_on_super_admin_id_and_role_id"
    t.index ["super_admin_id"], name: "index_super_admins_roles_on_super_admin_id"
  end

end
