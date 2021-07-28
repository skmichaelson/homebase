Rails.application.routes.draw do
  resources :shifts, only: [:index]
end
