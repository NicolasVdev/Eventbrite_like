# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Seed pour créer des utilisateurs avec des adresses @yopmail.com

# Générer une adresse email aléatoire avec le domaine @yopmail.com
def generate_yopmail_email
  username = Faker::Internet.unique.username
  "#{username}@yopmail.com"
end

# Créer 5 utilisateurs avec des adresses @yopmail.com
5.times do
  User.create!(
    email: generate_yopmail_email,
    encrypted_password: "password",
    description: Faker::Lorem.paragraph,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
