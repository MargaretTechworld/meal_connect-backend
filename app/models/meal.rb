class Meal < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_many :users, through: :reservations
end