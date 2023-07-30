Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customer, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'public/homes#top'

  namespace :admin do
    resources :order_details, only: [:show]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
    root to: 'homes#top'
  end
  namespace :public do
    post 'orders/confirm', as: 'order_confirm'
    get 'orders/finish', as: 'order_finish'
    get 'customers/:id/confirm_withdraw' => 'customers#confirm_withdraw', as: 'customer_confirm_withdraw'
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :create]
    resources :customers, only: [:show, :edit, :update]
    resources :items, only: [:index, :show]
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: 'customer_withdraw'
    patch 'cart_items/update/:id' => 'cart_items#update', as: 'cart_item_update'
    delete 'cart_items/destroy/:id' => 'cart_items#destroy', as: 'cart_item_destroy'
    delete 'cart_items/destroy_all', as: 'cart_items_destroy_all'
    get "/homes/about" => "homes#about", as: 'about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
