
require "open-uri"


ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")
Item.destroy_all
Breed.destroy_all

breeds = [["Siamois","siam"],["Abyssinian","abys"],["Bengal","beng"],["Birman","birm"]]

breeds.each do |breed_array_string|
  breed = Breed.create!(name: breed_array_string[0])
  url = "https://api.thecatapi.com/v1/images/search?limit=10&breed_ids=#{breed_array_string[1]}"
  response = URI.open(url).read
  data = JSON.parse(response)

  10.times do |i|
    item = Item.create!(
      title: Faker::Creature::Cat.name,
      description: Faker::Lorem.sentence,
      price: rand(1..10),
      breed: breed
    )
    image_url = data[i]["url"]
    file = URI.open(image_url)
    item.image.attach(io: file, filename: "item.jpg", content_type: "image/jpeg")
  end

end
ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")


# admin_user = User.create!(
#   email: 'mail@mail.com',
#   password: 'mailmail',
#   password_confirmation: 'mailmail'
# )

