Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, path: "auth", controllers: {confirmations: "confirmations"}

  root "static_pages#home"
  get "static_pages/help"
  resources :projects
  resources :companies
  resources :departments
  resources :workspaces
  resources :positions

  namespace :admin do
    root "static_pages#home"
    resources :users
  end

  resources :users
end
