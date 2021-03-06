Rails.application.routes.draw do
  root to: 'posts#index'
  resources :posts, only: [:new, :show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]
  end

  resources :tweets, only: [:index, :create, :destroy]

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
end
