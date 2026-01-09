Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end
  post '/graphql', to: 'graphql#execute'
  root 'daily_reports#index'
  resources :daily_reports, only: %i[index show new edit create update destroy]
  get 'up' => 'rails/health#show', as: :rails_health_check
end
