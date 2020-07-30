Rails.application.routes.draw do
  get 'tweets/new'
  get 'tweets/followers'
  get 'tweets/following'
  get 'users/search_index'
  get 'tweets/_latest_tweets'
  get 'home/index'
  get 'home/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#welcome'

  resources :tweets

  resources :tweets do
    resources :likes
  end


  resource :relationships, :only => [:create, :destroy]

 
  get '/users/:id', :to => 'home#show', :as => :user
  get '/users/:id', :to => 'tweets#index', :as => :thisuser





end
