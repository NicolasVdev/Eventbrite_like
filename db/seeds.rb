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
  User.create!(
    email: generate_yopmail_email,
    encrypted_password: "password",
    description: Faker::Lorem.paragraph,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
puts 'Utilisateurs créés avec succès.'

# Création des événements
3.times do
  Event.create(
    start_date: Faker::Time.between_dates(from: Date.today, to: Date.today + 30),
    title: Faker::Lorem.sentence,
    location: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    price: Faker::Number.between(from: 1, to: 1000),
    duration: rand(1..100)*5,
    administrator_id: User.all.sample.id
  )
end

puts 'Événements créés avec succès.'

# Création des participations
5.times do
  Attendance.create(stripe_customer_id: Faker::Alphanumeric.alphanumeric(number: 10), user_id: User.all.sample.id, event_id: Event.all.sample.id)
end

puts 'Participations créées avec succès.'