Rails.application.routes.draw do
  root 'homes#top'
  get  '/admin/:id', to: 'users#admin', as: "admin"
  get  'auth/:provider/callback', to: 'sessions#create'
  get  'auth/failure', to: redirect('/')
  get  'signout', to: 'sessions#destroy', as: 'signout'
  get  'cds/fav/:id' => 'cds#fav', as: "fav_cds"
  get  'cds/op_cd/:id' =>  'cds#op_cd', as:"op_cd" 
  post '/st_up',  to: 'users#st_up'

  resources :cds,      only: %i(create update destroy)
  resources :users,    only: %i(show create update destroy )
  resources :sessions, only: %i(create destroy)

end
