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

ActiveRecord::Schema[7.1].define(version: 2024_02_06_012514) do
  create_table "carousels", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "thumbnail"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carousels_on_user_id"
  end

  create_table "carousels_tags", id: false, force: :cascade do |t|
    t.integer "carousel_id", null: false
    t.integer "tag_id", null: false
  end

  create_table "quill_contents", force: :cascade do |t|
    t.float "width"
    t.float "height"
    t.float "x"
    t.float "y"
    t.string "delta"
    t.integer "slide_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slide_id"], name: "index_quill_contents_on_slide_id"
  end

  create_table "slides", force: :cascade do |t|
    t.string "title", default: ""
    t.integer "carousel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carousel_id"], name: "index_slides_on_carousel_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carousels", "users"
  add_foreign_key "quill_contents", "slides"
  add_foreign_key "slides", "carousels"
end
