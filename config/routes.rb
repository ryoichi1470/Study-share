Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  namespace :users do
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :edit, :update, :destroy] 
    end
    resource :relationships, only: [:create, :destroy]
      get ":user_id/followings" => "relationships#followings", as: "followings"
      get ":user_id/followers" => "relationships#followers", as: "followers"
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  resources :groups do
    resources :group_memberships, only: [:create, :update, :destroy]
  end  

  get 'mypage', to: 'users#mypage', as: 'mypage'
  get 'users/:id/mypage', to: 'users#show', as: 'user_mypage'
  
  resources :conversations, only: [:index, :create, :show] do
    resources :direct_messages, only: [:create]
  end


  
  resources :users, only: [:edit, :update]
  
  # resources :posts do
  #   resource :favorites, only: [:create, :destroy]
  # end

  root to: 'homes#top'
  get 'about', to: 'homes#about'
  get "search" => "searches#search"
end
