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
    context "basic index" do
      let!(:schedule1) { create(:schedule, name: 'Test 1') }
      let!(:schedule2) { create(:schedule, name: 'Test 2') }

      it "returns array of resources" do
        get schedules_path
        expect(response).to have_http_status(200)
        expect(json_items.length).to eq 2
        assert_payload_underscore(:schedule, schedule1, json_items[0])
        assert_payload_underscore(:schedule, schedule2, json_items[1])
      end

      it "filters by name" do
        get schedules_path, params: { filter: { name: 'Test 1' } }
        expect(response).to have_http_status(200)
        expect(json_items.length).to eq 1
        assert_payload_underscore(:schedule, schedule1, json_items[0])
      end
    end
  end

  describe "schedules#show" do
    context "basic find" do
      let!(:schedule) { create(:schedule) }

      it "returns resource" do
        get schedule_path(schedule.id)
        assert_payload_underscore(:schedule, schedule, json_item)
      end
    end

    context "with includes" do
      let!(:schedule) { create(:schedule) }
      let!(:scheduled_track1) { create(:scheduled_track, schedule: schedule) }

      it "returns scheduled_tracks with resource" do
        scheduled_track2 = create(:scheduled_track, schedule: schedule)

        get schedule_path(schedule.id)

        expect(json_includes('scheduled-tracks').length).to eq 2
        assert_payload_underscore(:scheduled_track, scheduled_track1, json_include('scheduled-tracks', 0))
        assert_payload_underscore(:scheduled_track, scheduled_track2, json_include('scheduled-tracks', 1))
      end

      it "returns scheduled_tracks with resource" do
        scheduled_track2 = create(:scheduled_track, state: 'played', schedule: schedule)

        get schedule_path(schedule.id)

        expect(json_includes('scheduled-tracks').length).to eq 1
        assert_payload_underscore(:scheduled_track, scheduled_track1, json_include('scheduled-tracks', 0))
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
