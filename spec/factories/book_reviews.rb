FactoryBot.define do
  factory :book_review do
    body 'Great book. Enjoyed it very much.'
    book
    user
  end
end
