Rails.application.routes.draw do
  resources :users
  resources :carousels
  resources :slides
  resources :quill_contents

  resources :users do
    get 'carousels', to: 'users#carousels_index'
  end
end
