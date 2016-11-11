Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root "static_pages#home"
  get "static_pages/help"
  resources :projects
  resources :workspaces
  resources :positions
  resources :departments

  namespace :admin do
    root "static_pages#home"
    resources :users
  end

  resources :users
end
