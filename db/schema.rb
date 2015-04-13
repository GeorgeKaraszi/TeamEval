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

ActiveRecord::Schema.define(version: 20150403142642) do

  create_table 'active_classes', force: true do |t|
    t.string 'name'
    t.string 'number'
    t.integer 'user_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'active_classes', ['user_id'], name: 'index_active_classes_on_user_id'

  create_table 'groups', force: true do |t|
    t.integer 'user_id'
    t.integer 'team_name_id'
    t.integer 'active_class_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'groups', ['active_class_id'], name: 'index_groups_on_active_class_id'
  add_index 'groups', ['team_name_id'], name: 'index_groups_on_team_name_id'
  add_index 'groups', ['user_id'], name: 'index_groups_on_user_id'

  create_table 'team_names', force: true do |t|
    t.string 'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'users', force: true do |t|
    t.string 'username', limit: 20
    t.string 'password_digest'
    t.string 'real_name', limit: 100
    t.integer 'id_type', default: 1
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

end
