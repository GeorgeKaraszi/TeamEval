# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

User.create!(username: 'Student1',
              password: 'pass123',
              password_confirmation: 'pass123',
              real_name: 'John Doe',
              id_type: 1)
User.create!(username: 'Student2',
              password: 'pass123',
              password_confirmation: 'pass123',
              real_name: 'Ken Student',
              id_type: 1)
User.create!(username: 'Instructor1',
              password: 'pass123',
              password_confirmation: 'pass123',
              real_name: 'Bob Profess',
              id_type: 2)
User.create!(username: 'Instructor2',
              password: 'pass123',
              password_confirmation: 'pass123',
              real_name: 'Did Professor',
              id_type: 2)
User.create!(username: 'Student3',
              password: 'pass123',
              password_confirmation: 'pass123',
              real_name: 'Joe Student',
              id_type: 1)