# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: %i[index new create edit update destroy]
  resources :user_sessions, only: %i[new create destroy]

  resources :departments, only: %i[index new create edit update destroy]
end
