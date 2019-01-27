Rails.application.routes.draw do

  get 'genres/index'
  get 'genres', to: 'genres#index'
  get 'genres/add'
  post 'genres/add'
  get 'genres/:id', to: 'genres#show'

  get 'genres/:id/edit', to: 'genres#edit'
  patch 'genres/:id/edit', to: 'genres#edit'
  get 'genres/:id/delete', to: 'genres#delete'
  post 'genres/:id/delete', to: 'genres#delete'

  get 'posts/like_ranking'

  devise_for :users

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

end
