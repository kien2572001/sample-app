Rails.application.routes.draw do
  constraints(locale: /en|vi/) do
    # Define your routes here
    resources :products
    get "static_pages/home"
    get "static_pages/help"
    # ...
  end
end
