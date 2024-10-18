Rails.application.routes.draw do
  namespace :admin do
    get 'groups/index'
    get 'groups/destroy'
  end
  get 'group_memberships/create'
  get 'group_memberships/update'
  
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
  end

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :groups, only: [:index, :destroy]
  end

  resources :groups do
    resources :group_memberships, only: [:create, :update]
  end  

  get 'mypage', to: 'users#mypage', as: 'mypage'
  get 'users/:id/mypage', to: 'users#show', as: 'user_mypage'

  
  resources :users, only: [:edit, :update]
  
  # resources :posts do
  #   resource :favorites, only: [:create, :destroy]
  # end

  root to: 'homes#top'
  get 'about', to: 'homes#about'
  get "search" => "searches#search"
end
