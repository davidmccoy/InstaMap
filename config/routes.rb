Rails.application.routes.draw do

  # index
  root 'home#index'

  # session sign in/out
  get '/users/login' => 'session#new'
  post '/session' => 'session#create'
  get '/users/signout' => 'session#destroy'

  # Instagram auth routes
  get '/oauth' => 'users#oauth'
  get '/callback' => 'users#oauth_callback'

  # Force email with signup
  match '/users/:id/complete_signup' => 'users#complete_signup', via: [:get, :patch], :as => :complete_signup

  # Instagram import
  get '/users/:id/import_recent' => 'users#import_recent'

  resources :users do
    resources :photos
    resources :maps
  end


end
