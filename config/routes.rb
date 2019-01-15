Rails.application.routes.draw do
  get  '/top', to: 'homes#top'
  root 'homes#top'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: %i(create destroy)
end
