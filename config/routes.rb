require 'sidekiq/web'

Rails.application.routes.draw do
  resources :service_requests
  ActiveAdmin.routes(self)
  get 'pages/home'
  get 'pages/about'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    scope :users, as: :users do
      post 'pre_otp', to: 'sessions#pre_otp'
    end
  end
  resource :two_factor

  root 'pages#home'

  mount Sidekiq::Web, at: '/sidekiq'
end
