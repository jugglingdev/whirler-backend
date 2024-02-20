Rails.application.routes.draw do
    root 'sessions#create'

    post 'login', to: 'sessions#create'
    post 'signup', to: 'users#create'

    get 'profile', to: 'users#show'
    put 'profile', to: 'users#update'
    delete 'profile', to: 'users#destroy'

    get 'dashboard', to: 'carousels#index'
    get 'carousel-edit/:id', to: 'carousels#slides_index'
    resources :carousels, only: [:show, :create, :update, :destroy] do
        resources :slides, only: [:create]
    end
    resources :slides, only: [:update, :destroy] do
        resources :quill_contents
    end
end
