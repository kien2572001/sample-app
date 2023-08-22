Rails.application.routes.draw do
  constraints(locale: /en|vi/) do
    # Define your routes here
    resources :products
    get "demo_partials/new"
    get "demo_partials/edit"
    get "static_pages/home"
    get "static_pages/help"
    # ...
  end
end
