Rails.application.routes.draw do

  get '/' => 'homes#top'

  resources :admins,only:[:new,:create,:show,:edit,:update]
  get 'admins/:id/users' => 'admins#users', as: 'admins_users'
  get 'a_login' => 'admins#login_form'
  post 'a_login' => 'admins#login'
  post 'a_logout' => 'admins#logout'
  get 'a_signup' => 'admins#new'

  resources :users,only:[:index,:new,:create,:show,:edit,:update]
  delete 'users/:id/destroy' => 'users#destroy', as: 'destroy_user'
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'signup' => 'users#new'

  get 'users/:id/likes' => 'users#like', as: 'like_users'
  get 'users/:id/following' => 'users#following', as: 'following_users'
  get 'users/:id/follower' => 'users#follower', as: 'follower_users'

  resources :items,only:[:index,:new,:create,:show,:edit,:update]
  delete 'items/:id' => 'items#destroy', as: 'destroy_item'


  post 'like/:id/create' => 'likes#create', as: 'create_like'
  post 'like/:id/destroy' => 'likes#destroy', as: 'destroy_like'

  resources :relationships, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


