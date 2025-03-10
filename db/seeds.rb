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

20.times do
  item = Item.create!(
    title: Faker::Creature::Cat.name,
    description: Faker::Lorem.sentence,
    price: rand(1..10)
  )

  # Ajout d'une image
  url = "https://api.thecatapi.com/v1/images/search"
  response = URI.open(url).read  # Ouvre l'URL et lit la réponse
  data = JSON.parse(response)   # Analyse la réponse JSON

  # Récupère l'URL de l'image du chat
  data[0]["url"]
  image_url = data[0]["url"] # Génère une image aléatoire de chat
  file = URI.open(image_url)
  item.image.attach(io: file, filename: "item.jpg", content_type: "image/jpeg")
end