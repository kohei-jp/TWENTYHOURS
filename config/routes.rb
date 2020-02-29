Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#index'
  resources :tweets do
    resources :comments, only: :create
  end
  resources :users, only: :show

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'homes#login'

end
