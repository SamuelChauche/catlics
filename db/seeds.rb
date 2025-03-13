
require "open-uri"


ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")
Item.destroy_all
Breed.destroy_all

breeds = [ [ "Siamois", "siam" ], [ "Abyssinian", "abys" ], [ "Bengal", "beng" ], [ "Birman", "birm" ] ]

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


User.create!(
  email: 'mail@mail.com',
  password: 'mailmail',
  role: "admin"
)


User.create!(email: 'joe@joe.com', password: 'joejoe')
User.create!(email: 'luc@joe.com', password: 'joejoe')
User.create!(email: 'tom@joe.com', password: 'joejoe')
User.create!(email: 'sam@joe.com', password: 'joejoe')
User.create!(email: 'titi@joe.com', password: 'joejoe')


10.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: "password",
    role: "user"
  )

  rand(10..50).times do
    order = Order.create!(
      user_id: user.id,

      status: ["pending", "validated", "cancelled"].sample,
      created_at: Faker::Date.between(from: '2024-01-01', to: '2025-12-31'),
      updated_at: Faker::Date.between(from: '2024-01-01', to: '2025-12-31')
    )

        rand(1..5).times do
          item = Item.all.sample
          OrderItem.create!(
            order_id: order.id,
            item_id: item.id,
            quantity: rand(1..3),
            price: item.price
          )
        end
      end
    end
