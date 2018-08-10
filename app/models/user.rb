class User < ApplicationRecord
  has_many :book_ratings
  has_many :book_reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
end
