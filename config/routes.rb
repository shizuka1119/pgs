Rails.application.routes.draw do

  resources :admins
  get 'a_login' => 'admins#login_form'
  post 'a_login' => 'asmins#login'
  post 'a_logout' => 'admins#logout'
  get 'a_signup' => 'admins#new'

  get '/' => 'homes#top'

  resources :users
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'signup' => 'users#new'




  resources :items,only:[:index,:new,:create,:show,:edit,:update]
  delete 'items/:id' => 'items#destroy', as: 'destroy_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

