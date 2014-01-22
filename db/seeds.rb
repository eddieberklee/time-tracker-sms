# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

titles = [
  'its a good morning i feel lazy for waking up so late. i need to shower then get dressed',
  'showering',
  'checking up on my devices now and email and facebook',
  'signing up for rsf',
  'getting lunch at koja today, their rice buns are so nicely cooked',
  'getting ready to go to cs161',
  'getting ready to go to ugba 196 right after cs161',
  'heading home',
  'got home',
  'on computer',
  'facebook/music',
  'studying up on technical interviews',
  'getting my schedule for this week figured out',
]

datetimes = [
  DateTime.new(2014,1,22,11,53,00,'-8'),
  DateTime.new(2014,1,22,12,14,00,'-8'),
  DateTime.new(2014,1,22,12,48,00,'-8'),
  DateTime.new(2014,1,22,13,14,00,'-8'),
  DateTime.new(2014,1,22,13,44,00,'-8'),
  DateTime.new(2014,1,22,14,58,00,'-8'),
  DateTime.new(2014,1,22,16,11,00,'-8'),
  DateTime.new(2014,1,22,18,01,00,'-8'),
  DateTime.new(2014,1,22,21,41,00,'-8'),
  DateTime.new(2014,1,22,22,11,00,'-8'),
  DateTime.new(2014,1,22,22,59,00,'-8'),
  DateTime.new(2014,1,22,23,25,00,'-8'),
  DateTime.new(2014,1,22,23,30,00,'-8'),
  DateTime.new(2014,1,22,23,32,00,'-8'),
  DateTime.new(2014,1,22,23,52,00,'-8'),
]

i = 0

titles.each do |t|
  e=Event.create(:title=>t)
  e.created_at = datetimes[i]
  e.start_time = datetimes[i]
  e.end_time = datetimes[i+1]
  e.save
  i += 1
end





