class Place < ApplicationRecord
  has_many :users

  def self.lat_and_lon(place_id)
    place = Place.find(place_id)
    lat = place.lat
    lon = place.lon
    return lat,lon
  end
end
