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

  get "/" => "public/homes#top"
  get "about" => "public/homes#about", as: "about"
  namespace :public do
    resources :items, only:[:index,:show]
    resources :orders, only:[:new,:confirm,:complete,:index,:show]
    resources :cart_items, only:[:index,:update,:create,:destroy,:destroy_all]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
    resources :addresses, only: [:index,:edit,:create,:update,:destroy]
  end

  namespace :admin do
    get "/" => 'homes#top'
    get 'orders/show'
    get 'status/update'
    get 'making_status/update'
    resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
