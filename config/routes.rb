Rails.application.routes.draw do
  resources :products
  resources :stores, except: [:destroy]
  resources :profiles, except: [:destroy]
  devise_for :users
  root to: 'home#index'

  # get "product/new/option" => 'products#add_option', :as => :add_option
  get 'cart/new' =>'cart#new'
  post 'cart' => 'cart#create', :as => :add_cart
  get 'cart' => 'cart#show', :as => :my_cart
  patch 'cart' => 'cart#update', :as => :update_item
  delete 'cart' => 'cart#destroy', :as => :destroy_item


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
