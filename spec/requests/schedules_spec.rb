require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "GET /schedules" do
    it "works! (now write some real specs)" do
      schedule1 = Schedule.create(name: 'test 1')
      schedule2 = Schedule.create(name: 'test 2')
      get schedules_path
      expect(response).to have_http_status(200)

      assert_payload_underscore(:schedule, schedule1, json_items[0])
      assert_payload_underscore(:schedule, schedule2, json_items[1])
    end
  end
end
