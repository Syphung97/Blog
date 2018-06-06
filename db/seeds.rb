# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Author.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "123123",
             password_confirmation: "123123",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123123"
  Author.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
authors = Author.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(1)
  content = Faker::Lorem.sentence(5)
  catalog = "html"
  authors.each do |user|
     user.posts.create!(title: title, content: content, catalog: catalog)
  end
end

authors = Author.all
author  = authors.first
following = authors[2..50]
followers = authors[3..40]
following.each { |followed| author.follow(followed) }
followers.each { |follower| follower.follow(author) }
