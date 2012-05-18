Appvulture::Application.routes.draw do
  resources :lenses

  resources :changes

  resources :apps

  resources :users
  resources :sessions
  resources :password_resets
  resources :apps

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  root to: 'apps#index'
end
