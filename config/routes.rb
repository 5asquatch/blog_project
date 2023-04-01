Rails.application.routes.draw do
  devise_for :users
  resources :users
 

  root to: "posts#index"
  get "/user", to: "posts#show"
  get "/followers/:id", to: "users#followers"
  get "/subscribes/:id", to: "users#subscribes"
  get "/search", to: "users#search"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  delete "/posts:id", to: "likes#destroy"

  resources :posts do
    resources :likes 
    resources :comments
  end
end