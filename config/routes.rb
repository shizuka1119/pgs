Rails.application.routes.draw do

  get '/' => 'homes#top'

  resources :admins
  get 'a_login' => 'admins#login_form'
  post 'a_login' => 'asmins#login'
  post 'a_logout' => 'admins#logout'
  get 'a_signup' => 'admins#new'

  resources :users
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'signup' => 'users#new'

  get 'users/:id/likes' => 'users#like'
  get 'users/:id/following' => 'users#following'
  get 'users/:id/follower' => 'users#follower'

  resources :items,only:[:index,:new,:create,:show,:edit,:update]
  delete 'items/:id' => 'items#destroy', as: 'destroy_item'


  post 'like/:id/create' => 'likes#create'
  post 'like/:id/destroy' => 'likes#destroy'

  resources :relationships, only: [:create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

