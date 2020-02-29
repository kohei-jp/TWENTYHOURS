Rails.application.routes.draw do
<<<<<<< Updated upstream
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
  #======================================
=======
  root "home#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'tweets#index'
  resources :tweets
>>>>>>> Stashed changes
end
