Rails.application.routes.draw do
  root "home#index"

  devise_for :accounts, controllers: { registrations: 'registrations' }

  namespace :api do
    post "internal/authenticate_with_extra_ids", controller: "internal_api", action: :authenticate_with_extra_ids
    post "internal/transfer_with_extra_ids",     controller: "internal_api", action: :transfer_with_extra_ids
  end
end
