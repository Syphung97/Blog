Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  get "/about", to: "static_pages#about"
  get "/contact",to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :authors do
    member do
      resources :followings, :followers, only: [:index]
    end
  end
  resources :posts do
    resources :comments
    resources :likes
  end

  resources :relationships, only: [:create, :destroy]
end
