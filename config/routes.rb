Rails.application.routes.draw do
  scope path: '/api' do
    scope path: '/v1' do
      resources :schedules
      resources :scheduled_tracks
    end
  end
end
