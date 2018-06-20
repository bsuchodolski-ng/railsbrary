require 'ffaker'

FactoryBot.define do
  factory :book do
    title { FFaker::Book.title }
    author
  end
end
