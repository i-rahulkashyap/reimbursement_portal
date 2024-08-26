Rails.application.routes.draw do
  # resources :users
  devise_for :users
  resources :users do
    member do
      patch :change_password
      get 'add_to_employee'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home#index"
  resources :employees
  resources :departments 
  resources :bills do
    member do
      patch :approve
      patch :reject
    end
  end
end
