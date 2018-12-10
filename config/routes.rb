Rails.application.routes.draw do
  devise_for :users
  resources :comments, except: [:show]
  resources :products
  resources :stores, except: [:destroy]
  resources :profiles, except: [:new, :destroy]
  
  get "/my_profile" => "profiles#my_profile", as: :my_profile
  
  root to: 'home#main'
  get '/home/index', to: "home#index", as: :index
  
  get '/payments' => 'payments#new', :as => :new_payment
  get '/payments/kakao/success' => 'payments#kakao_success'
  get '/payments/kakao/cancel' => 'payments#kakao_cancel'
  get '/payments/kakao/fail' => 'payments#kakao_fail'
  get '/payments/kakao' => 'payments#kakao', :as => :kakao

  match '/cart' => 'cart#create', :as => :add_cart_item, via: [:put, :patch]
  get '/cart' => 'cart#show', :as => :my_cart
  get '/cart/:option_id' => 'cart#edit', :as => :edit_cart_item
  put '/cart' => 'cart#update', :as => :update_cart_item
  delete '/cart' => 'cart#destroy', :as => :destroy_cart
  delete '/cart/:id' => 'cart#destroy_item', :as => :destroy_cart_item
  
  post '/:id/like', to:"votes#like", as: :like
  delete '/:id/like', to:"votes#unlike", as: :unlike
  
  post '/:id/thumb', to:"votes#thumb_down", as: :thumb_down
  delete '/:id/thumb', to:"votes#thumb_up", as: :thumb_up
  
  post '/:id/follow', to:"follows#toggle", as: :follow
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
