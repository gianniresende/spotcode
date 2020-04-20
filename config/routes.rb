Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  concern :favoritable do |options|
    shallow do
      post "/favorite", { to: "favorites#create", on: :member }.merge(options)
      delete "/favorite", { to: "favorites#destroy", on: :member }.merge(options)
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :dashboard, only: :index
      resources :search, only: :index
      resources :categories, only: %i[index show]
      resources :favorites, only: :index
      resources :albums, only: :show do
        resources :recently_heards, only: :create
      end
    end
  end
end
