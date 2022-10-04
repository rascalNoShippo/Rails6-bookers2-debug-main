Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get "following" => "relationships#following", as: "following"
    get "followers" => "relationships#followers", as: "followers"
    resources :chats, only: [:index, :create]
  end
  resources :groups, only: [:index, :show, :edit, :new, :create, :update, :destroy] do
    resource :participations, only: [:create, :destroy]
    resource :events, only: [:new, :create]
  end
  get "search" => "searches#search"

  root to: "homes#top"
  get "home/about"=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
