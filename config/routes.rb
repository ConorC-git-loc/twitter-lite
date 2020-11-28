Rails.application.routes.draw do
  get 'tweets/new'
  get 'tweets/followers'
  get 'tweets/following'
  get 'users/search_index'
  get 'tweets/_latest_tweets'
  get 'home/index'
  get 'home/show'
  get 'home/search_index'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#welcome'

  resources :tweets do
    resources :comments
    resources :likes
    member do
      patch :pin
      patch :unpin
    end
    member do
      post :retweet
    end
  end

  resource :relationships, only: %i[create destroy]

  get '/users/:id', to: 'home#show', as: :user
  get '/users/:id', to: 'tweets#index', as: :thisuser
  get '/users/:id', to: 'tweets#following', as: :followinguser
end
