class TrailsController < ApplicationController
    belongs_to :user
    belongs_to :trail

    validates :location, prescence: true
end
