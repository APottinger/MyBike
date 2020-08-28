class Trail < ApplicationRecord
  belongs_to :user
  belongs_to :bike
  validates :location, presence: true

  def self.search_trail(params)
    Trail.where("LOWER(trails.location) LIKE :term", term: "%#{params}%")
  end

end