Rails.application.routes.draw do

  resources :comments, except: [:show]
  resources :products
  resources :stores, except: [:destroy]
  resources :profiles, except: [:destroy]
  devise_for :users
  root to: 'home#index'

  get 'payments' => 'payments#new', :as => :new_payment
  get 'payments/kakao/success' => 'payments#kakao_success'
  get 'payments/kakao/cancel' => 'payments#kakao_cancel'
  get 'payments/kakao/fail' => 'payments#kakao_fail'
  get 'payments/kakao' => 'payments#kakao', :as => :kakao

  post 'cart' => 'cart#create', :as => :add_cart_item
  get 'cart' => 'cart#show', :as => :my_cart
  get 'cart/:option_id' => 'cart#edit', :as => :edit_cart_item
  put 'cart' => 'cart#update', :as => :update_cart_item
  delete 'cart' => 'cart#destroy', :as => :destroy_cart
  delete 'cart/:id' => 'cart#destroy_item', :as => :destroy_cart_item


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
