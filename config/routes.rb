Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root "static_pages#home"
  get "static_pages/help"
  namespace :admin do
    resources :workspaces
  end

end
