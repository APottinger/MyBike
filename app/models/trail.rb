class Trail < ApplicationRecord
  belongs_to :user
  belongs_to :bike
  validates :location, presence: true
end
