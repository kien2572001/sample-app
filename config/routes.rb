Rails.application.routes.draw do
  constraints(locale: /en|vi/) do
    # Define your routes here
    # root define
    root "static_pages#home"
    # static page controller
    get "/help", to: "static_pages#help"
    
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: :show

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    # ...
  end
end
