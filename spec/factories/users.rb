FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    first_name 'John'
    last_name  'Doe'
    password 'password'
  end
end
