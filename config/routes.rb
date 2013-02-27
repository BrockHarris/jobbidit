Jobbidit::Application.routes.draw do

  match '/homeowners',  :to => 'pages#homeowners'
  match '/contractors',  :to => 'pages#contractors'
  match '/faq',  :to => 'pages#faq'
  match '/about',  :to => 'pages#about'
  match '/privacypolicy',  :to => 'pages#privacypolicy'
  match '/contact',  :to => 'pages#contact'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'sessions#signup'
  match '/usertype', :to => 'users#usertype'
  match '/assist', :to => 'users#assist'
  match '/jobspage', :to => 'jobs#main'
  match '/settings', :to => 'users#settings'
  match "/reset/:id/:reset_code", :to=>"users#reset", :as=>"reset"
  match '/activate/:id/:activation_code', :to=>"users#activation", :as=>"activate"
  match "/activate_user/:id", :to=>"users#activate", :as=>"activate_user"
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "pages#home"
  match "/welcome_user/:id", :to=>"users#welcome", :as=>"welcome_user"
  match "complete_session_authentication_path", :to=>"authentications#complete_session_authentication", :as=>:complete_session_authentication

  resources :messages
  resources :users
  resources :authentications
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :bids
  resources :comments

  resources :jobs do
      member do
        post :request
      end
  end
  resources :jobphotos

  root :to => 'pages#home'

end
