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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140904165555) do

  create_table "actor_movies", force: true do |t|
    t.integer "actor_id"
    t.integer "movie_id"
  end

  create_table "actors", force: true do |t|
    t.string "name"
  end

  create_table "genre_movies", force: true do |t|
    t.integer "genre_id"
    t.integer "movie_id"
  end

  create_table "genres", force: true do |t|
    t.string "genre"
  end

  create_table "movies", force: true do |t|
    t.string   "imdb",                                null: false
    t.string   "year",                                null: false
    t.float    "score",                               null: false
    t.integer  "probability",                         null: false
    t.string   "poster",      default: "default.jpg"
    t.string   "title",                               null: false
    t.text     "plot"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["imdb"], name: "index_movies_on_imdb"

end
