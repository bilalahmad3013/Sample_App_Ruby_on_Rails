Rails.application.routes.draw do   
  get 'like/create'
  get 'like/delete'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  get '/signup', to: 'users#new'
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy' 
  # get '/micropost/:id/toggle_like', to: 'like#toggle', as: 'toggle_like'

  # delete '/micropost/:id/toggle_like', to: 'like_controller#delete'

  resources :users do
    member do
    get :following, :followers
    end
  end
  
  resources :microposts do
    member do
      post 'toggle_like', to: 'like#toggle'
    end
  end
  
  

  root 'static_pages#home'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end