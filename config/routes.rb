Rails.application.routes.draw do

  get  '/top', to: 'homes#top'
  root 'homes#top'
  get  '/admin', to: 'users#admin'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  patch '/image_update',  to: 'users#image_update', as: "image_update"

  resources :cds,      only: %i(create update destroy)
  resources :users,    only: %i(show create update destroy )
  resources :sessions, only: %i(create destroy)

end
