Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', :to => "users#new"
  get 'users/new'
  get 'sessions/new'
  get '/contact', :to => "static_pages#contact"
  get '/term', :to => "static_pages#term"
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :questions do
    member do
    put "like" => "questions#upvote"
    put "unlike" => "questions#downvote"      
    end
  end

  resources :comments
  resources :relationships, only: [:create, :destroy]

  resources :users do
    collection do
    get 'search'
    end
  end
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
