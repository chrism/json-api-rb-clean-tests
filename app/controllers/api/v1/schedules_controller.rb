class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.all
    render jsonapi: schedules
  end
end
