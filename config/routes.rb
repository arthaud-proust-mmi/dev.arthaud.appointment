Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock' }, :controllers => { registrations: 'users/registrations' }
  # devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_up: 'register', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'registerwtf' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Rails.application.routes.draw do
    # devise_for :users, controllers: {
      # sessions: 'users/sessions'
    # }
  # end

  # Defines the root path route ("/")
  # root "home#index"
  root "home#index"
end
