# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :wallets, only: %i[index show] do
    resources :transactions, only: %i[index show]
  end

  resources :cards do
    resources :transactions, only: %i[index show]
  end

  post 'transactions', to: 'transactions#create'

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  # namespace :admin do
  #   resources :users, :wallets
  #   resources :transactions, only: [:index, :show]
  # end
end
