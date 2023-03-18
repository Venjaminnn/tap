# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'sessions#new'

  post '/sign_up', to: 'users#create'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/feed', to: 'feeds#index'

  resources :users, only: %i[show index]
  resources :posts, only: %i[new create update] do
    get :edit
    resources :comments, only: %i[new create index destroy], controller: 'posts/comments'
    resources :likes, only: %i[], controller: 'posts/likes' do
      get 'create', on: :collection, to: 'posts/likes#create'
      get 'destroy', on: :collection, as: :destroy, to: 'posts/likes#destroy'
    end
  end

  resources :follows, only: %i[create] do
    collection do
      delete '/:following_id', action: :destroy, as: :unfollow
    end
  end

  namespace :api do
    post '/sign_up', to: 'users#create'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    get '/feed', to: 'feeds#index'

    resources :comments, only: :destroy
    resources :posts, only: %i[create update] do
      resources :comments, only: %i[create index], controller: 'posts/comments'
      resources :likes, only: %i[create index], controller: 'posts/likes' do
        delete 'destroy', on: :collection
      end
    end

    resources :follows, only: %i[create] do
      collection do
        delete '/:following_id', action: :destroy
      end
    end
  end
end
