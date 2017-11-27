module Helpers
  def assert_payload_underscore(payload, model, json)
    assert_payload(payload, model, json.transform_keys{ |k| k.to_s.underscore })
  end
end
