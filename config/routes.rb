Rails.application.routes.draw do
  devise_for :users
  resources :vinyls, only: %i[index create show destroy]
  resources :scans, only: %i[new create show]
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route (“/”)
  root "pages#home"
  # require "sidekiq/web"
  # authenticate :user, ->(user) { user.admin? } do
  #     mount Sidekiq::Web => '/sidekiq'
  # end

  get "authenticate", to: "pages#authenticate"
  get "callback", to: "pages#callback"
end
