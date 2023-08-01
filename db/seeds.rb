# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a main sample user.
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "Foobar_1",
             password_confirmation: "Foobar_1",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Generate a bunch of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "Password1"
    User.create!(name:  name,
                 email: email,
                 password:              password,
                 password_confirmation: password,
                 activated: true,
                 activated_at: Time.zone.now)
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
10.times do
  name = Faker::Lorem.sentence(word_count: 3)
  description = Faker::Lorem.sentence(word_count: 15)
  users.each { |user| user.toys.create!(name: name, description: description) }
end
