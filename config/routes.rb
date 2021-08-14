require 'sidekiq/web'

Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/about'

  devise_for :users
  root 'pages#home'

  mount Sidekiq::Web, at: '/sidekiq'
end
