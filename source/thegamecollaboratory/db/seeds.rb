# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create name: 'GKN 1a', email: 'gknuser1af1@example.com', password: 'password', role: '1a', company: 'Example, LLC', facility_id: f_gkn1.id

User.create first_name: "Super", last_name: "Admin", email: "testsuper@example.com", password: "password", role: "2"
User.create first_name: "Admin", last_name: "Administrator", email: "testadmin@example.com", password: "password", role: "1"
User.create first_name: "Public", last_name: "User", email: "testuser@example.com", password: "password", role: "0"