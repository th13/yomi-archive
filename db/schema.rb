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

ActiveRecord::Schema.define(version: 20151201092831) do


  create_table "keywords", force: :cascade do |t|
    t.integer  "sentence_id"
    t.integer  "word_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "keywords", ["sentence_id"], name: "index_keywords_on_sentence_id"
  add_index "keywords", ["word_id"], name: "index_keywords_on_word_id"

  create_table "sentences", force: :cascade do |t|
    t.text     "jpn"
    t.text     "eng"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sentences", ["user_id"], name: "index_sentences_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "vocabs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vocabs", ["user_id"], name: "index_vocabs_on_user_id"
  add_index "vocabs", ["word_id"], name: "index_vocabs_on_word_id"

  create_table "words", force: :cascade do |t|
    t.string   "jpn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "words", ["jpn"], name: "index_words_on_jpn", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "e_password"
    t.string   "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
