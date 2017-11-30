class Schedule < ApplicationRecord
  has_many :scheduled_tracks, dependent: :destroy
  has_many :forthcoming_tracks, -> { where(state: ['playing','next','queued']) }, class_name: "ScheduledTrack"

  validates_presence_of :name
end
