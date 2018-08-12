FactoryBot.define do
  factory :book_review do
    body 'Great book'
    book
    user
  end
end
