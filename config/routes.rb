Rails.application.routes.draw do
  resources :meets
  resources :services
  devise_for :users, path: '', path_names: { 
    sign_in: '/login', 
    sign_up: '/register', 
    sign_out: '/logout', 
    password: 'secret', 
    edit: 'account/edit', 
    confirmation: 'verification', 
    unlock: 'unblock' 
  }, :controllers => { registrations: 'users/registrations' }
  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'registerwtf' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Rails.application.routes.draw do
  resources :meets
  resources :services
  get '/my-meets', to: 'meets#index_self'

  get '/', to: 'home#index', as: 'home'
  # Defines the root path route ("/")
  # root "home#index"
  root "home#index"
end
