class Schedule < ApplicationRecord
  has_many :scheduled_tracks
  
  validates_presence_of :name
end
