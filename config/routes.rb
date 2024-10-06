Rails.application.routes.draw do
  namespace :users do
    resources :posts
  end
  devise_for :users
  root to: "homes#top"
  get 'about', to: 'homes#about'
  
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
