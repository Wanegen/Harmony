Rails.application.routes.draw do
  devise_for :users
  resources :vinyls, only: %i[index show destroy]
  resources :users do
    resources :scans, only: %i[new create show]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"
end
