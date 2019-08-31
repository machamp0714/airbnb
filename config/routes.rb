# frozen_string_literal: true

Rails.application.routes.draw do
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users do
    member do
      post "verify_phone_number", to: "users#verify_phone_number"
      patch "update_phone_number", to: "users#update_phone_number"
    end
  end
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
    resources :calendars
  end
  resources :guest_reviews, only: [:create, :destroy]
  resources :host_reviews, only: [:create, :destroy]
  resources :reservations, only: [:approve, :decline] do
    member do
      post "approve", to: "reservations#approve"
      post "dicline", to: "reservations#dicline"
    end
  end

  get "dashboard", to: "dashboards#index"
  get "your_trips", to: "reservations#your_trips"
  get "your_reservations", to: "reservations#your_reservations"
  get "search", to: "pages#search"
  get "host_calendar", to: "calendars#host"
  root "pages#top"
end
