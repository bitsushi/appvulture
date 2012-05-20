Appvulture::Application.routes.draw do
  resources :lenses

  resources :changes

  resources :apps

  resources :users
  resources :sessions
  resources :password_resets
  resources :apps
  resources :ioses, path: '', constraints: {subdomain: "ios"}
  resources :macs, path: '', constraints: {subdomain: "mac"}
  resources :xboxes, path: '', constraints: {subdomain: "xbox"}
  resources :androids, path: '', constraints: {subdomain: "android"}

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  root to: 'apps#index'
end
