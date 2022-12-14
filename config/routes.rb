Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  authenticate :user do
    namespace :admin do
      resources :users
      resources :projects
    end
    resources :reports
  end
end
