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

ActiveRecord::Schema.define(:version => 20120830184752) do

  create_table "aja_scores", :force => true do |t|
    t.integer  "diamond_id"
    t.string   "tab_percent"
    t.string   "crown_angle"
    t.string   "crown_height"
    t.string   "pavilion_depth"
    t.string   "girdle"
    t.string   "depth"
    t.string   "polish"
    t.string   "symmetry"
    t.string   "total_grade"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "aja_scores", ["diamond_id"], :name => "index_aja_scores_on_diamond_id"

  create_table "diamonds", :force => true do |t|
    t.string   "bn_number"
    t.string   "gia_number"
    t.decimal  "carat_weight"
    t.string   "color"
    t.string   "clarity"
    t.string   "cut_grade"
    t.decimal  "height_mm"
    t.decimal  "diameter_max"
    t.decimal  "diameter_min"
    t.decimal  "table_size"
    t.decimal  "total_depth"
    t.decimal  "crown_angle"
    t.decimal  "crown_height"
    t.decimal  "pavillion_angle"
    t.decimal  "pavillion_depth"
    t.decimal  "star_length"
    t.decimal  "lower_half_length"
    t.string   "girdle_min"
    t.string   "girdle_max"
    t.string   "cutlet_size"
    t.string   "polish"
    t.string   "symmetry"
    t.string   "flourescence"
    t.string   "aga_naja_grade"
    t.integer  "ship_time"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "current_price_id"
    t.boolean  "archived",          :default => false
    t.string   "shape"
    t.boolean  "favorite"
  end

  create_table "hca_scores", :force => true do |t|
    t.integer  "diamond_id"
    t.decimal  "score"
    t.string   "light_return"
    t.string   "fire"
    t.string   "scintillation"
    t.string   "spread"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "price_snapshots", :force => true do |t|
    t.integer  "diamond_id"
    t.decimal  "price"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "price_snapshots", ["diamond_id"], :name => "index_price_snapshots_on_diamond_id"

end
