class DeserializableSchedule < JSONAPI::Deserializable::Resource
  key_format { |k| k.underscore }

  attributes
end
