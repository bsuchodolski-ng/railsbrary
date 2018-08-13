require 'ffaker'

puts 'Create users and authors'
20.times do
  User.create(
    email: FFaker::Internet.email,
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    password: 'password'
  )

  Author.create(name: FFaker::Name.name)
end

puts 'Create books'
Author.all.each do |author|
  5.times do
    author.books.create(
      title: FFaker::Book.title,
      published_at: Time.at(rand((Time.now - (1500*60*24*365*5))..Time.now)),
      cover_image: File.open(Rails.root + "app/assets/images/seeds/#{rand(1..5)}.png"),
      description: FFaker::Lorem.paragraph(rand(3..8))
    )
  end
end

puts 'Create ratings and reviews'
User.all.each do |user|
  Book.all.each do |book|
    book.book_ratings.create(user: user, rating: rand(1..5))
    book.book_reviews.create(user: user, body: FFaker::Lorem.paragraph(rand(1..4)))
  end
end

puts 'Create main user'
User.create(
  email: 'qwe@qwe.qwe',
  first_name: 'John',
  last_name: 'Doe',
  password: 'password'
)
