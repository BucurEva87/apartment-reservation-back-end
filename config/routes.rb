Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    resources :apartments, only: [:index, :create, :show, :destroy, :update]
    resources :users, only: [:create]
    resources :reservations, only: [:index, :create, :show, :destroy, :update]
  end
end
