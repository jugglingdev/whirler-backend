Rails.application.routes.draw do
  get 'sessions/create'

  scope '/' do
    post 'login', to: 'sessions#create'
  end

  post '/signup', to: 'users#create'

  resources :users, only: [:create, :update, :destroy] do
    get 'profile', to: 'users#show'
    patch 'change_password', to: 'users#change_password'
    resources :carousels, only: [:index] # For Dashboard view
  end

  resources :carousels, only: [:show, :create, :update, :destroy] do
    resources :slides, only: [:index, :create] # For Carousel Edit view
  end

  resources :slides, only: [:show, :update, :destroy] do
    resources :quill_contents, only: [:index, :create] # For Carousel Edit view
  end

end
