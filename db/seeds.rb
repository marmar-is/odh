# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
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
=end
# Admins
AdminUser.create!(email: 'admin@example.com', role: 1, password: 'password', password_confirmation: 'password')

# Payout Matrix
PayoutMatrix.create!(generation: 1, amount: 30)
PayoutMatrix.create!(generation: 2, amount: 25)
PayoutMatrix.create!(generation: 3, amount: 20)

# Teams
Team.create(name: "Arizona Cardinals",    conference: "NFC West")
Team.create(name: "Atlanta Falcons",      conference: "NFC South")
Team.create(name: "Baltimore Ravens",     conference: "AFC North")
Team.create(name: "Buffalo Bills",        conference: "AFC East")
Team.create(name: "Carolina Panthers",    conference: "NFC South")
Team.create(name: "Chicago Bears",        conference: "NFC North")
Team.create(name: "Cincinnati Bengals",   conference: "AFC North")
Team.create(name: "Cleveland Browns",     conference: "AFC North")
Team.create(name: "Dallas Cowboys",       conference: "NFC East")
Team.create(name: "Denver Broncos",       conference: "AFC West")
Team.create(name: "Detroit Lions",        conference: "NFC North")
Team.create(name: "Green Bay Packers",    conference: "NFC North")
Team.create(name: "Houston Texans",       conference: "AFC South")
Team.create(name: "Indianapolis Colts",   conference: "AFC South")
Team.create(name: "Jacksonville Jaguars", conference: "AFC South")
Team.create(name: "Kansas City Chiefs",   conference: "AFC West")
Team.create(name: "Miami Dolphins",       conference: "AFC East")
Team.create(name: "Minnesota Vikings",    conference: "NFC North")
Team.create(name: "New England Patriots", conference: "AFC East")
Team.create(name: "New Orleans Saints",   conference: "NFC South")
Team.create(name: "NY Giants",            conference: "NFC East")
Team.create(name: "NY Jets",              conference: "AFC East")
Team.create(name: "Oakland Raiders",      conference: "AFC West")
Team.create(name: "Philadelphia Eagles",  conference: "NFC East")
Team.create(name: "Pittsburgh Steelers",  conference: "AFC North")
Team.create(name: "San Diego Chargers",   conference: "AFC West")
Team.create(name: "San Francisco 49ers",  conference: "NFC West")
Team.create(name: "Seattle Seahawks",     conference: "NFC West")
Team.create(name: "St. Louis Rams",       conference: "NFC West")
Team.create(name: "Tampa Bay Buccaneers", conference: "NFC South")
Team.create(name: "Tennessee Titans",     conference: "AFC South")
Team.create(name: "Washington Redskins",  conference: "NFC East")

# Weeks
Week.create(number: 1, start: Time.now-2.days, deadline: Time.now+5.days)
Week.create(number: 2, start: Time.now+5.days, deadline: Time.now+12.days)
Week.create(number: 3, start: Time.now+12.days, deadline: Time.now+19.days)
Week.create(number: 4, start: Time.now+26.days, deadline: Time.now+33.days)

# Expositions
Exposition.create(week: Week.first, home: Team.first, away: Team.second, when: Time.now, point_spread:7.5)
Exposition.create(week: Week.first, home: Team.second, away: Team.last, when: Time.now+1.days, point_spread:-5.0)
Exposition.create(week: Week.first, home: Team.third, away: Team.first, when: Time.now+2.days, point_spread:0.0)
Exposition.create(week: Week.first, home: Team.fourth, away: Team.last, when: Time.now+3.days, point_spread:10.0)
