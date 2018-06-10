Rails.application.routes.draw do
  devise_for :users
  get 'users', to: redirect('users/sign_up')
  root to: 'dashboard#show'
end
