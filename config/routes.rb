Appvulture::Application.routes.draw do
  resources :users
  resources :sessions
  resources :password_resets

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  root to: 'users#index'
end
