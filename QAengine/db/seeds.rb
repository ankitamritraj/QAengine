# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             city: "Mandi",
             state: "Himachal Pradesh",
             institution: "Indian Institute of Technology Mandi",
             reputation: 10,
             password:              "foobar",
             password_confirmation: "foobar")

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  city =  "Mandi"
  state =  "Himachal Pradesh"
  institution = "Indian Institute of Technology Mandi"
  reputation = 10
  password = "password"
  User.create!(name:  name,
               email: email,
               city: city,
               state: state,
               institution: institution,
               reputation: reputation,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(10)
20.times do
content = Faker::Lorem.sentence(5)
users.each { |user| user.questions.create!(content: content) }
end