require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "schedules#create" do
    context "basic create" do
      let(:payload) do
        {
          data: {
            type: 'schedules',
            attributes: {
              name: 'Test'
            }
          }
        }
      end

      it "creates resource" do
        expect {
          jsonapi_post schedules_path, payload
        }.to change { Schedule.count }.by(1)
        schedule = Schedule.last

        assert_payload_underscore(:schedule, schedule, json_item)
      end
    end
  end

  describe "schedules#index" do
    let!(:schedule1) { create(:schedule) }
    let!(:schedule2) { create(:schedule) }

    it "basic index" do
      get schedules_path
      expect(response).to have_http_status(200)

      assert_payload_underscore(:schedule, schedule1, json_items[0])
      assert_payload_underscore(:schedule, schedule2, json_items[1])
    end
  end

  describe "schedules#show" do
    context "basic find" do
      let!(:schedule) { create(:schedule) }

      it "serializes resource" do
        get schedule_path(schedule.id)

        assert_payload_underscore(:schedule, schedule, json_item)
      end
    end
  end

  describe "schedules#update" do
    context "basic update" do
      let!(:schedule) { create(:schedule) }

      let(:payload) do
        {
          data: {
            id: schedule.id.to_s,
            type: 'schedules',
            attributes: {
              name: "Test changed",
              "current-position": 2
            }
          }
        }
      end

      it 'updates resource' do
        expect {
          jsonapi_put schedule_path(schedule.id), payload
        }.to change { schedule.reload.attributes }
        assert_payload_underscore(:schedule, schedule, json_item)
        expect(json_item['name']).to eq "Test changed"
        expect(json_item['current-position']).to eq 2
      end
    end
  end

  describe "schedules#destroy" do
    context "basic destroy" do
      let!(:schedule) { create(:schedule) }

      it "destroys resource" do
        expect {
          delete schedule_path(schedule.id)
        }.to change { Schedule.count }.by(-1)

        expect(response.status).to eq(204)
      end
    end
  end
end
