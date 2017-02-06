Rails.application.routes.draw do
  resources :users, only: [:show, :create, :update, :destroy]
  post '/auth', to: 'authentication#create'
end
