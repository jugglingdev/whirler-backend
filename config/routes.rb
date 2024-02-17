Rails.application.routes.draw do
  get 'sessions/create'

  scope '/' do
    post 'login', to: 'sessions#create'
  end

  resources :users do
    get 'carousels', to: 'users#carousels_index'
  end

  resources :carousels do
    get 'slides', to: 'carousels#slides_index'
  end

  resources :slides do
    get 'quill_contents', to: 'slides#quill_contents_index'
  end

  resources :quill_contents

end
