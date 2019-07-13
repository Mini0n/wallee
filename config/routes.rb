# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :wallets, only: %i[index show] do
    resources :transactions, only: %i[index show create]
  end

  resources :cards do
    resources :transactions, only: %i[index show]
  end

  # namespace :admin do
  #   resources :users, :wallets
  #   resources :transactions, only: [:index, :show]
  # end
end
