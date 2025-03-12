Rails.application.routes.draw do

  root "items#index"

  devise_for :users
  resources :users, only: [:show]
  resources :cart_items, only: [ :create, :destroy, :update ]

  resources :items, only: [ :show, :create, :new ]

  resource :cart, only: [ :show, :update, :destroy ] do
    post "add_item/:item_id", to: "carts#add_item", as: "add_item"
  end

  resources :orders, only: [ :index, :create, :show ]

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  get "up" => "rails/health#show", as: :rails_health_check
  

end
