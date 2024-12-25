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

ActiveRecord::Schema[7.2].define(version: 2024_12_25_145405) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.integer "data_code", null: false
    t.integer "openweathermap_city_code", null: false
    t.string "name", null: false
    t.string "prefecture", null: false
    t.string "region", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_code"], name: "index_cities_on_data_code", unique: true
    t.index ["openweathermap_city_code"], name: "index_cities_on_openweathermap_city_code", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.integer "weather_id"
    t.integer "humidity"
    t.integer "deg"
    t.integer "pressure"
    t.integer "visibility"
    t.float "temp_max"
    t.float "temp_min"
    t.float "temp_feel"
    t.float "speed"
    t.datetime "fetched_at", null: false
    t.datetime "sunrise_date"
    t.datetime "sunset_date"
    t.string "main"
    t.string "description"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_weathers_on_city_id"
  end

  add_foreign_key "weathers", "cities"
end
