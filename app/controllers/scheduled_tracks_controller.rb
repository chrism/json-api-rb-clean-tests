class ScheduledTracksController < ApplicationController
  deserializable_resource :scheduled_track, only: [:create, :update]
  before_action :set_scheduled_track, only: [:update, :destroy]

  def index
    scheduled_tracks = ScheduledTrack.all
    render jsonapi: scheduled_tracks
  end

  def show
    render jsonapi: ScheduledTrack.includes(:schedule).find(params[:id]), include: ['schedule']
  end

  def create
    scheduled_track = ScheduledTrack.new(scheduled_track_params)

    if scheduled_track.save
      render jsonapi: scheduled_track
    else
      render jsonapi_errors: scheduled_track.errors
    end
  end

  def update
    if @scheduled_track.update(scheduled_track_params)
      render jsonapi: @scheduled_track
    else
      render jsonapi_errors: @scheduled_track.errors
    end
  end

  def destroy
    if @scheduled_track.destroy
      head :no_content
    else
      render jsonapi_errors: @scheduled_track.errors
    end
  end

  private
    def set_scheduled_track
      @scheduled_track = ScheduledTrack.find(params[:id])
    end

    def scheduled_track_params
      params.require(:scheduled_track).permit(:state, :position, :schedule_id)
    end
end
