Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    resource :session, only: [:create, :destroy, :show]
    resource :user, only: [:create, :show]
    resources :listings, only: [:index, :show, :create]
    resources :bookings, only: [:create, :index]
    resources :reviews, only: [:create]
    resources :cities, only: [:index]
  end
  root "static_pages#root"
end
