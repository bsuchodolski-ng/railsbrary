class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :email, presence: true
  validates :password, presence: true, confirmation: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
