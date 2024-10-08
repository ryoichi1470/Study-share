Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations', 
    sessions: 'users/sessions'            
  }
  
  
  namespace :users do
    resources :posts
  end

  
  get 'mypage', to: 'users#mypage', as: 'mypage'              
  get 'users/:id/mypage', to: 'users#show', as: 'user_mypage'  

  
  root to: 'homes#top'
  get 'about', to: 'homes#about'

  
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end
