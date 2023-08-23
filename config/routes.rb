Rails.application.routes.draw do
  constraints(locale: /en|vi/) do
    # Define your routes here
    resources :products
    get "static_pages/home"
    get "static_pages/help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: :show
    # ...
  end
end
