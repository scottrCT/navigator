# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100920211031) do

  create_table "comments", :force => true do |t|
    t.string   "visit_frequency"
    t.string   "survey_for"
    t.string   "specific_info"
    t.string   "ease_of_use"
    t.string   "useful"
    t.string   "overall"
    t.text     "comments"
    t.string   "zip"
    t.string   "ip_addr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "eitcs", :force => true do |t|
    t.integer  "year"
    t.integer  "filing_status"
    t.integer  "children_no"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fpls", :force => true do |t|
    t.integer  "year"
    t.integer  "base_amt"
    t.integer  "offset"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "income_frequencies", :force => true do |t|
    t.string   "frequency"
    t.integer  "annual_multiplier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "link_trackers", :force => true do |t|
    t.string   "ip_addr"
    t.integer  "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey"
  end

  create_table "program_links", :force => true do |t|
    t.integer  "program_id"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "fpl_max"
    t.float    "smi_max"
    t.float    "annual_income_max"
    t.string   "method_nm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residencies", :force => true do |t|
    t.text     "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "select_options", :force => true do |t|
    t.string   "list_option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smis", :force => true do |t|
    t.integer  "year"
    t.integer  "family_size"
    t.float    "amt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "age"
    t.integer  "residency_id"
    t.integer  "resident_of_CT"
    t.integer  "have_a_spouse"
    t.integer  "children_under_18"
    t.integer  "adult_dependants"
    t.integer  "children_under_13"
    t.integer  "children_under_5"
    t.integer  "adult_disability"
    t.integer  "pregnant"
    t.integer  "currently_employed"
    t.integer  "spouse_currently_employed"
    t.integer  "other_income"
    t.integer  "tax_filing_method_id"
    t.integer  "approved_training_activity"
    t.integer  "spouse_approved_training_activity"
    t.decimal  "net_income_amt",                    :precision => 18, :scale => 2
    t.integer  "net_income_frequency"
    t.decimal  "spouse_net_income_amt",             :precision => 18, :scale => 2
    t.integer  "spouse_net_income_frequency"
    t.decimal  "other_income_amt",                  :precision => 18, :scale => 2
    t.integer  "other_income_frequency"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "programs"
    t.string   "ip_addr"
  end

  create_table "tax_filing_methods", :force => true do |t|
    t.text     "tax_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
