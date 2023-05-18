require 'open-uri'
require 'uri'

User.destroy_all
Event.destroy_all
Attendance.destroy_all

# Générer une adresse email aléatoire avec le domaine @yopmail.com
def generate_yopmail_email
  username = Faker::Internet.unique.username
  "#{username}@yopmail.com"
end

# Créer 5 utilisateurs avec des adresses @yopmail.com
5.times do
  user = User.create!(
    email: generate_yopmail_email,
    password: "password",
    description: Faker::Lorem.paragraph,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name 
  )
  avatar_url = URI.parse('https://i.pravatar.cc/300')
  user.avatar.attach(io: avatar_url.open, filename: 'avatar.jpg')
end

puts 'Utilisateurs créés avec succès.'

# Création des événements
5.times do
  Event.create!(
    start_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 30),
    title: Faker::Lorem.sentence,
    location: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.between(from: 1, to: 1000),
    duration: rand(1..100)*5,
    administrator_id: User.all.sample.id,
    img_url: "https://loremflickr.com/#{rand(200..250)}/#{rand(150..200)}/event"
  )
end

puts 'Événements créés avec succès.'

# Création des participations
3.times do
  Attendance.create!(stripe_customer_id: Faker::Alphanumeric.alphanumeric(number: 10), attendee_id: User.all.sample.id, event_id: Event.all.sample.id)
end

puts 'Participations créées avec succès.'