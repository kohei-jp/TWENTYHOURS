Rails.application.routes.draw do
  devise_for :users
  root  'tops#index'
  namespace :tweets do
    resources :searches, only: :index
  end

  resources :tweets do
    resources :comments, only: :create
    resource :favorites, only: [:create, :destroy]
  end

  # ================ここをネスト(入れ子)した形に変更
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end
  resources :users, only: :show

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'homes#login'

end
