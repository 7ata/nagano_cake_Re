Rails.application.routes.draw do


  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
 # 管理者用
# URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations, :passwords],controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to: 'homes#top'
    get "about" => "homes#about", as: "about"
    resources :items, only:[:index,:show]

    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    resources :customers, only: [:show, :edit, :update]

    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only:[:index,:update,:create,:destroy]

    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    resources :orders, only:[:new,:index,:show,:create]

    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end

  namespace :admin do
    get "/" => 'homes#top'
    patch 'order_details/update'
    resources :orders, only: [:show, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
