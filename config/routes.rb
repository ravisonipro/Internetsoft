Rails.application.routes.draw do
  devise_for :users
  
  resources :users, except: [:show] do
    collection do
      get 'users_dashboard'
    end
  end

  root 'users#index'

  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end
