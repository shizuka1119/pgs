Rails.application.routes.draw do

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
