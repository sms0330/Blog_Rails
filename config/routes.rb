Rails.application.routes.draw do
  root "posts#index"

  resources :posts do
    resources :comments
  end

  resources :users, only: [:new, :create, :edit, :update]

  get('/users/:id/edit_password', {to: 'users#edit_password', as: 'edit_password'})
  patch('/users/:id/update_password', {to: 'users#update_password', as: 'update_password'})

  resource :session, only: [:new, :create, :destroy]

  
end
