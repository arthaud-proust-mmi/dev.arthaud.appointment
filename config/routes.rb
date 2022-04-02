Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { 
    sign_in: '/login', 
    sign_up: '/register', 
    sign_out: '/logout', 
    password: 'secret', 
    edit: 'account/edit', 
    confirmation: 'verification', 
    unlock: 'unblock' 
  }, :controllers => { registrations: 'users/registrations' }

  resources :meets

  scope '/pro' do
    get '/', to: 'pro#index', as: :pro
    resources :services, except: [:index]
    get '/services', to: 'services#index_self'
    get '/agenda', to: 'meets#agenda'
  end


  get '/my-meets', to: 'meets#index_self', as: :my_meets
  
  get '/services', to: 'services#index', as: :customer_services
  get '/services/:id', to: 'services#show', as: :customer_service
  get '/services/:id/book', to: 'services#book', as: :customer_book_service
  get '/services/:id/taken-dates', to: 'services#taken_dates', as: :taken_dates_service

  get '/', to: 'home#index', as: :home
  root "home#index"
end
