class SerializableSchedule < JSONAPI::Serializable::Resource
  extend JSONAPI::Serializable::Resource::KeyFormat

  key_format { |key| key.to_s.dasherize }

  type 'schedules'
  attributes :name, :current_position

  has_many :scheduled_tracks do
    data do
      @object.scheduled_tracks
    end
  end

  link :self do
    @url_helpers.schedule_url(@object.id)
  end
end
