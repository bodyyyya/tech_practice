Rails.application.routes.draw do
  get 'orders/new'
  get 'carts/show'
  get 'products/index'
  get 'products/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'cart_items_count', to: 'cart_items#count'
  devise_for :users

  resources :products
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :orders, only: [:new, :create] do
    collection do
      get :thank_you
    end
  end
  resources :categories do
    get :properties_form, on: :member
  end

  get 'about', to: 'pages#about', as: 'about'
  

  root 'products#index'
  # Defines the root path route ("/")
  # root "posts#index"
end
