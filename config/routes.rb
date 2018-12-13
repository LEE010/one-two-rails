Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

  devise_for :users
  resources :comments, except: [:show]
  resources :products
  
  resources :stores, except: [:destroy]
  get '/store/:id/management', to:"stores#management", as: :manage_store
  
  resources :profiles, except: [:new, :destroy]
  resources :posts, except: [:index,:show]
  
  get "/my_profile" => "profiles#my_profile", as: :my_profile
  
  root to: 'home#main'
  get '/home/index', to: "home#index", as: :index
  get '/home/search', to: "home#search", as: :search
  
  get '/payments/:total_amount' => 'payments#new', as: :new_payment
  get '/payments/kakao/success' => 'payments#kakao_success'
  get '/payments/kakao/cancel' => 'payments#kakao_cancel'
  get '/payments/kakao/fail' => 'payments#kakao_fail'
  get '/payments/kakao/:total_amount' => 'payments#kakao', :as => :kakao

  match '/cart' => 'cart#create', :as => :add_cart_item, via: [:post, :put, :patch]
  get '/cart' => 'cart#show', :as => :my_cart
  get '/cart/:option_id' => 'cart#edit', :as => :edit_cart_item
  put '/cart' => 'cart#update', :as => :update_cart_item
  delete '/cart' => 'cart#destroy', :as => :destroy_cart
  delete '/cart/:id' => 'cart#destroy_item', :as => :destroy_cart_item
  
  post '/like/:votable/:id', to:"votes#like", as: :like
  delete '/like/:votable/:id', to:"votes#unlike", as: :unlike
  
  post '/thumb/:votable/:id', to:"votes#thumb_down", as: :thumb_down
  delete '/thumb/:votable/:id', to:"votes#thumb_up", as: :thumb_up
  
  post '/follow/:followable/:id', to:"follows#toggle", as: :follow
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
