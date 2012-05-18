Appvulture::Application.routes.draw do
  resources :users
  resources :sessions

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  root to: 'users#index'
end
