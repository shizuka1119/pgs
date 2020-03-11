Rails.application.routes.draw do
  get '/' => 'homes#top'
  resources :items,only:[:index,:new,:create,:show,:edit,:update]
  delete 'items/:id' => 'items#destroy', as: 'destroy_item'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
