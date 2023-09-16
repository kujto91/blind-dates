# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'groups#index'

  resources :users, only: %i[index new create edit update destroy]
  resources :user_sessions, only: %i[new create destroy]

  resources :departments, only: %i[index new create edit update destroy]
  resources :restorants, only: %i[index new create edit update destroy]

  resources :groups, only: %i[index create edit update destroy]
  resources :group_invitations, only: %i[index edit update destroy]
end
