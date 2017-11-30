class SerializableScheduledTrack < JSONAPI::Serializable::Resource
  extend JSONAPI::Serializable::Resource::KeyFormat

  key_format { |key| key.to_s.dasherize }

  type 'scheduled-tracks'
  attributes :state, :position

  belongs_to :schedule
end
