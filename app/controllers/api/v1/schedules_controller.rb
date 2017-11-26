class Api::V1::SchedulesController < ApplicationController
  deserializable_resource :schedule, only: [:create, :update]

  def index
    schedules = Schedule.all
    render jsonapi: schedules
  end

  def show
    schedule = Schedule.find(params[:id])
    render jsonapi: schedule
  end

  def create
    schedule = Schedule.new(schedule_params)

    if schedule.save
      render jsonapi: schedule
    else
      render jsonapi_errors: schedule.errors
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:name)
    end
end
