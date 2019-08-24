# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: [:edit]
  resources :rooms, except: [:edit] do
    member do
      get :listing
      get :pricing
      get :description
      get :photo_upload
      get :amenities
      get :location
      get :preload
      get :preview
    end
    resources :photos, only: [:create, :destroy]
    resources :reservations, only: [:create]
  end
  get "your_trips", to: "reservations#your_trips"
  get "your_reservations", to: "reservations#your_reservations"
  root "pages#top"
end
