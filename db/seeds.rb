# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



require "open-uri"


ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")
Item.destroy_all
# ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")


siam = Breed.create!(name: "siam")
# Ajout d'une image
url_siam = "https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=siam"
response = URI.open(url_siam).read  # Ouvre l'URL et lit la réponse
data_siam = JSON.parse(response)   # Analyse la réponse JSON


1.times do |i|
  item = Item.create!(
    title: Faker::Creature::Cat.name,
    description: Faker::Lorem.sentence,
    price: rand(1..10),
    breed: siam
  )



  # Récupère l'URL de l'image du chat
  data_siam[i]["url"]
  image_url = data_siam[0]["url"] # Génère une image aléatoire de chat
  file = URI.open(image_url)
  item.image.attach(io: file, filename: "item.jpg", content_type: "image/jpeg")
end

# admin_user = User.create!(
#   email: 'mail@mail.com',
#   password: 'mailmail',
#   password_confirmation: 'mailmail'
# )

# puts "Utilisateur admin créé avec succès :"
# puts "Email: #{admin_user.email}"
# puts "Mot de passe: mailmail"
