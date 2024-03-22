Rails.application.routes.draw do
    root 'sessions#create'

    post 'login', to: 'sessions#create'
    post 'signup', to: 'users#create'

    get 'profile', to: 'users#show'
    put 'profile', to: 'users#update'
    delete 'profile', to: 'users#destroy'

    resources :carousels do
        resources :slides, only: [:index, :create]
    end

    resources :slides, only: [:show, :update, :destroy] do
        resources :quill_contents, only: [:index, :create]
    end

    resources :quill_contents, only: [:show, :update, :destroy]

    resources :tags, only: [:index, :create]
end
