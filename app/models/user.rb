class User < ApplicationRecord
    has_many :bikes
    has_many :trails
    has_many :completed_trails, through: :trails, source: :bike
    has_secure_password

    validates :username, :email, presence: true
end
