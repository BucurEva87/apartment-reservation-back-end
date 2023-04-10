Rails.application.routes.draw do
  devise_for :users

  root 'home#index'

  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
end
