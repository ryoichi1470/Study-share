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
      resources :comments, only: [:create, :edit, :update, :destroy] 
    end
  end

  get 'mypage', to: 'users#mypage', as: 'mypage'
  get 'users/:id/mypage', to: 'users#show', as: 'user_mypage'

  root to: 'homes#top'
  get 'about', to: 'homes#about'
  get "search" => "searches#search"
end
