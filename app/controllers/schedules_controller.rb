class SchedulesController < ApplicationController
  deserializable_resource :schedule, class: DeserializableSchedule, only: [:create, :update]
  before_action :set_schedule, only: [:show, :update, :destroy]

  def index
    schedules = Schedule.all
    render jsonapi: schedules
  end

  def show
    render jsonapi: @schedule
  end

  def create
    schedule = Schedule.new(schedule_params)

    if schedule.save
      render jsonapi: schedule
    else
      render jsonapi_errors: schedule.errors
    end
  end

  def update
    if @schedule.update(schedule_params)
      render jsonapi: @schedule
    else
      render jsonapi_errors: @schedule.errors
    end
  end

  def destroy
    if @schedule.destroy
      head :no_content
    else
      render jsonapi_errors: @schedule.errors
    end
  end

  private
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:name, :current_position)
    end
end
