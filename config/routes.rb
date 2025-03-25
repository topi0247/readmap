Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static_pages#index"

  get "/login", to: "sessions#new", as: "login"

  resources :users, only: %i[show edit]
  resources :lists, only: %i[index show] do
    resources :books, only: %i[new show edit]
  end
end
