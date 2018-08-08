FactoryBot.define do
  factory :book_rating do
    rating 5
    book
    user
  end
end
