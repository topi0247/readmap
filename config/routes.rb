Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static_pages#index"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :users, only: %i[index show edit update]
  resources :lists do
    resources :books, except: %i[index]
  end
end
