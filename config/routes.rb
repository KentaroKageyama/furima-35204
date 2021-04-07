Rails.application.routes.draw do

  get 'cards/new'
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :orders, only: [:index, :create]
    resources :messages, only: :create
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show]
  resources :cards, only: [:index, :new, :create, :destroy]
end
