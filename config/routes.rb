require 'sidekiq/web'

Rails.application.routes.draw do
  resources :service_requests do
    get 'take_request', to: 'service_requests#take_request'
    get 'btn', to: 'service_requests#add_buttons'
  end
  resource :two_factor

  ActiveAdmin.routes(self)

  get 'pages/home'
  get 'pages/about'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    scope :users, as: :users do
      post 'pre_otp', to: 'sessions#pre_otp'
    end
  end

  root 'pages#home'

  mount Sidekiq::Web, at: '/sidekiq'
end
