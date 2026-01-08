Rails.application.routes.draw do
  root 'daily_reports#index'
  resources :daily_reports, only: %i[index show new edit create update destroy]
  get 'up' => 'rails/health#show', as: :rails_health_check
end
