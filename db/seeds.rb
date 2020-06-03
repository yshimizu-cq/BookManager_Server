require 'faker'

10.times do |n|
  user = User.create(email: Faker::Internet.email, password: 'password')
  rand(1..10).times do |n|
    book = user.books.build(
      name: Faker::Book.title,
      image_url: "http://bookimage.jpg",
      purchase_date: "2020-06-01",
      price: 2000
    )
    book.save
  end
end
