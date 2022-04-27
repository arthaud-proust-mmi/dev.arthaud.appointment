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

  resources :meets, except: [:index]

  scope '/pro' do
    get '/', to: 'pro#index', as: :pro
    get '/edit', to: 'pro#edit', as: :edit_pro
    patch '/edit', to: 'pro#update', as: :update_pro
    resources :services, except: [:index]
    get '/services', to: 'services#index_self', as: :services_self
    get '/agenda', to: 'agenda#index', as: :agenda
    get '/agenda/old', to: 'agenda#index_old', as: :agenda_old
    get '/:id', to: 'pro#show', as: :show_pro

  end


  get '/my-meets', to: 'meets#index', as: :my_meets
  get '/my-meets/old', to: 'meets#index_old', as: :my_meets_old
  
  get '/services', to: 'services#index', as: :customer_services
  get '/services/:id', to: 'services#show', as: :customer_service
  get '/services/:id/book', to: 'services#book', as: :customer_book_service
  get '/services/:id/taken-dates', to: 'services#taken_dates', as: :taken_dates_service


  get '/', to: 'home#index', as: :home
  get '/account', to: 'home#show', as: :account
  root "home#index"
end
