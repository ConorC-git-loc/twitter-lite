Rails.application.routes.draw do
  get 'home/index'
  get 'home/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  match 'users/:id' => 'home#show', via: :get


end
