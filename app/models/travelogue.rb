class Travelogue < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :gmaps, :latitude, :longitude
end
