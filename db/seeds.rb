# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
# Seed Population

# Delete all existing records to start fresh
PostTag.delete_all
Post.delete_all
Tag.delete_all
User.delete_all
Faker::Config.locale = "en"
# Crear usuarios
user1 = User.create(name: "John Doe", email: "john@Uandes.com", password: "password")
4.times do |n|
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  User.create(name: name, email: email, password: "password")
end

# Crear tags
tag1 = Tag.create(name: "Tag 1")
4.times do |n|
  Tag.create(name: Faker::Lorem.word.capitalize)
end

# Crear posts asociados a usuarios y tags
10.times do |n|
  user = User.offset(rand(User.count)).first
  post = user.posts.create(title: "Post #{n+1}", content: Faker::Lorem.paragraph)
  post.tags << tag1
end

# Crear relaciones post_tag adicionales
Post.all.each do |post|
  post.tags << Tag.offset(rand(Tag.count)).first unless post.tags.include?(tag1)
end


  
