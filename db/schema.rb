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

ActiveRecord::Schema.define(:version => 20120317155344) do

  create_table "feedbacks", :force => true do |t|
    t.string    "email"
    t.text      "message"
    t.integer   "membre_id"
    t.boolean   "lu",         :default => false
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
  end

  create_table "lols", :force => true do |t|
    t.integer   "vanne_id"
    t.integer   "membre_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "membres", :force => true do |t|
    t.string    "pseudo"
    t.string    "hashed_passwd"
    t.string    "salt"
    t.string    "email"
    t.timestamp "created_at",                       :null => false
    t.timestamp "updated_at",                       :null => false
    t.boolean   "admin",         :default => false
  end

  create_table "vannes", :force => true do |t|
    t.text      "contenu"
    t.integer   "membre_id"
    t.timestamp "created_at",                    :null => false
    t.timestamp "updated_at",                    :null => false
    t.integer   "lols_count", :default => 0
    t.boolean   "valide",     :default => false
  end

end
