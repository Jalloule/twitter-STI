Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'teste-monitoramento' => 'health_check#teste_monitoramento'
  get 'teste-email' => 'health_check#teste_email'

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Leave open only the routes you're actually using

  resources :tweets

  # current_user
  namespace :account do
    resource :followings, only: [:show]
    resources :followers, only: [:index, :update, :destroy]
  end

  # other user
  resources :users do
    resource :followings, only: [:show]
    resource :followers, only: [:show]
    resource :follows, only: [:create, :destroy]
  end

  resources :notifications, only: [:index, :create]
end