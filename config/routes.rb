Rails.application.routes.draw do
  get 'tweets/new'
  get 'tweets/followers'
  get 'tweets/following'
  get 'home/index'
  get 'home/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'tweets#index'

  resources :tweets


  resource :relationships, :only => [:create, :destroy]

 
  get '/users/:id', :to => 'home#show', :as => :user
  get '/users/:id', :to => 'tweets#index', :as => :thisuser




end
