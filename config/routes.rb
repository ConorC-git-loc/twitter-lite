Rails.application.routes.draw do
  get 'tweets/new'
  get 'home/index'
  get 'home/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :tweets, only: [:new, :create, :show, :index]
  resources :relationships, :only => [:create, :destroy]

 

  get '/users/:id', :to => 'home#show', :as => :user
  get '/users/:id', :to => 'tweets#index', :as => :thisuser




end
