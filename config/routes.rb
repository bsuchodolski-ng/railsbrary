Rails.application.routes.draw do
  root to: 'dashboard#show'

  devise_for :users
  get 'users', to: redirect('users/sign_up')

  resources :books, only: [:new, :show]
  get 'books/search', to: 'books#index'
  post 'books/new', to: 'books#create', as: 'books'

  post 'authors/new', to: 'authors#create'
end
