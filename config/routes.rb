Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: "static_pages#index"

  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout

  resources :users, only: %i[show edit update]
  resources :lists do
    resources :books, except: %i[index]
  end

  namespace :api do
    namespace :v1 do
      get "search_books", to: "books#search"
    end
  end
end
