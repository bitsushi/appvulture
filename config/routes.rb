Appvulture::Application.routes.draw do
  resources :changes

  resources :apps

  resources :users
  resources :sessions
  resources :password_resets
  resources :apps

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  root to: 'users#index'
end
