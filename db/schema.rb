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

ActiveRecord::Schema[7.2].define(version: 2024_10_31_192737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "institution", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "pix_keys", primary_key: "key", id: :string, force: :cascade do |t|
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_pix_keys_on_account_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "transfer_type", null: false
    t.float "value", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "cpf", null: false
    t.string "email", null: false
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "pix_keys", "accounts"
  add_foreign_key "transfers", "accounts", column: "receiver_id"
  add_foreign_key "transfers", "accounts", column: "sender_id"
end
