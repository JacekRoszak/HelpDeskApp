require 'sidekiq/web'

Rails.application.routes.draw do
  resources :service_requests do
    get 'assign_technician', to: 'service_requests#assign_technician'
    get 'btn', to: 'service_requests#add_buttons'
    get 'process', to: 'service_requests#process_request'
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

  root 'service_requests#index'

  mount Sidekiq::Web, at: '/sidekiq'
end
