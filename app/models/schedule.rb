class Schedule < ApplicationRecord
  has_many :scheduled_tracks, dependent: :destroy

  validates_presence_of :name
end
