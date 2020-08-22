class Bike < ApplicationRecord
  belongs_to :user
  has_many :trails
  has_many :users, through: :trails
  validates :name, :type, presence: true

  scope :alpha, -> { order(:title) }
end
