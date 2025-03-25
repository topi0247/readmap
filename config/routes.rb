Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static_pages#index"

  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :users, only: %i[show edit update]
  resources :lists do
    resources :books, except: %i[index]
  end
end
