class SerializableSchedule < JSONAPI::Serializable::Resource
  extend JSONAPI::Serializable::Resource::KeyFormat

  key_format { |key| key.to_s.dasherize }

  type 'schedules'
  attributes :name, :current_position

  link :self do
    @url_helpers.api_v1_schedule_url(@object.id)
  end
end
