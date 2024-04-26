# config/routes.rb
Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show]
  resources :tags, only: [:index, :show]
end
