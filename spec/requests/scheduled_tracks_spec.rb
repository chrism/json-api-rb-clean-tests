require 'rails_helper'

RSpec.describe "Scheduled Tracks", type: :request do
  describe "schedules#index" do
    context "basic index" do
      let!(:schedule) { create(:schedule) }
      let!(:scheduled_track1) { create(:scheduled_track, schedule: schedule) }
      let!(:scheduled_track2) { create(:scheduled_track, schedule: schedule) }

      it "returns array of resources" do
        get scheduled_tracks_path
        expect(response).to have_http_status(200)
        assert_payload_underscore(:scheduled_track, scheduled_track1, json_items[0])
        assert_payload_underscore(:scheduled_track, scheduled_track2, json_items[1])
      end
    end
  end

  describe "schedules#show" do
    context "basic find" do
      let!(:schedule) { create(:schedule) }
      let!(:scheduled_track) { create(:scheduled_track, schedule: schedule) }

      it "returns resource" do
        get scheduled_track_path(scheduled_track.id)
        assert_payload_underscore(:scheduled_track, scheduled_track, json_item)
      end
    end
  end

  describe "scheduled_tracks#create" do
    context "basic create" do
      let!(:schedule) { create(:schedule) }
      let(:payload) do
        {
          data: {
            type: 'scheduled_tracks',
            attributes: {
              state: 'What',
              position: 1
            },
            relationships: {
              schedule: {
                data: { type: "schedules", id: schedule.id.to_s }
              }
            }
          }
        }
      end

      it "creates resource" do
        expect {
          jsonapi_post scheduled_tracks_path, payload
        }.to change { ScheduledTrack.count }.by(1)
        scheduled_track = ScheduledTrack.last
        assert_payload_underscore(:scheduled_track, scheduled_track, json_item)
      end
    end
  end

  describe "scheduled_tracks#update" do
    context "basic update" do
      let!(:schedule) { create(:schedule) }
      let!(:scheduled_track) { create(:scheduled_track, schedule: schedule) }

      let(:payload) do
        {
          data: {
            id: scheduled_track.id.to_s,
            type: 'scheduled_tracks',
            attributes: {
              state: "playing"
            }
          }
        }
      end

      it 'updates resource' do
        expect {
          jsonapi_put scheduled_track_path(scheduled_track.id), payload
        }.to change { scheduled_track.reload.attributes }
        assert_payload_underscore(:scheduled_track, scheduled_track, json_item)
        expect(json_item['state']).to eq "playing"
      end
    end
  end

  describe "schedules#destroy" do
    context "basic destroy" do
      let!(:schedule) { create(:schedule) }
      let!(:scheduled_track) { create(:scheduled_track, schedule: schedule) }

      it "destroys resource" do
        expect {
          delete scheduled_track_path(scheduled_track.id)
        }.to change { ScheduledTrack.count }.by(-1)

        expect(response.status).to eq(204)
      end
    end
  end
end
