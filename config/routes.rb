Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  resources :users do
    member do
      get :login_as
    end
  end
  resources :facebook_posts, only: [:index]
  resources :wordpress_posts, only: [:index]
  resources :statistics, only: [:index]
end
