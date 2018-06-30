Rails.application.routes.draw do
  root to: 'dashboard#show'

  devise_for :users
  get 'users', to: redirect('users/sign_up')

  resources :books, only: [:new, :show, :index, :create]

  post 'authors/new', to: 'authors#create'
end
