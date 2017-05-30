Rails.application.routes.draw do
  devise_for :users,
      controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'recipes#index'

  resources :users, only: [:show]
  resources :recipes  do
    resources :transactions, only: [:new, :create, :edit, :update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
