# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post '/sign_up', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/feed', to: 'feeds#index'

  resources :comments, only: :destroy
  resources :posts, only: %i[create update] do
    resources :comments, only: :create
    resources :comments, only: :index, controller: 'posts/comments'
  end

  resources :follows, only: %i[create] do
    collection do
      delete '/:following_id', action: :destroy
    end
  end
end
