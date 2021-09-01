Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    resources :favourites, shallow: true, only: [:create, :destroy]
    get :favourited, on: :collection
    resources :comments do
      resources :likes, shallow: true, only: [:create, :destroy]
    end
  end

  resources :users, only: [:new, :create, :edit, :update]

  get('/users/:id/edit_password', {to: 'users#edit_password', as: 'edit_password'})
  patch('/users/:id/update_password', {to: 'users#update_password', as: 'update_password'})

  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do 
      resources :posts
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] do
        get :current, on: :collection
      end
    end
    match "*unmatched_route", to: "application#not_found", via: :all
  end

  
end
