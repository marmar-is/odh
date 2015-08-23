# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
a = Ambassador.new(
  email: 'aaa@gmail.com',
  phone: '5446665676',
  fname: 'matt',
  lname: 'vass',
  dob: '1995-11-08',
  street: '94 van',
  city: 'prince',
  state: 'NJ',
  zip: ''
)
Admin.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')