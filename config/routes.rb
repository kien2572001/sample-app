Rails.application.routes.draw do
  get 'followers/index'
  get 'followings/index'
  constraints(locale: /en|vi/) do
    # Define your routes here
    # root define
    root "static_pages#home"
    # static page controller
    get "/help", to: "static_pages#help"
    
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: [:show, :index, :edit, :update, :destroy]
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)

    resources :users do
      member do
        get :followings , to: "followings#index"
        get :followers, to: "followers#index"
      end
    end


    resources :relationships, only: %i(create destroy)

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    # ...
  end
end
