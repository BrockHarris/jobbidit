Jobbidit::Application.routes.draw do

  match '/homeowners',  :to => 'pages#homeowners'
  match '/contractors',  :to => 'pages#contractors'
  match '/faq',  :to => 'pages#faq'
  match '/about',  :to => 'pages#about'
  match '/privacypolicy',  :to => 'pages#privacypolicy'
  match '/contact',  :to => 'pages#contact'
  match '/signin',  :to => 'sessions#new'
  match '/signup',  :to => 'users#new'
  match '/signout', :to => 'sessions#destroy'
  match '/adminsignout', :to => 'adminsessions#destroy'
  match '/usertype', :to => 'users#usertype'
  match '/assist', :to => 'users#assist'
  match '/settings', :to => 'users#settings'
  match '/fbform', :to => 'users#fbform'
  match '/inbox', :to => 'pmessages#index'
  match '/admin', :to => 'pages#admin_panel'
  match "/auth/:provider/callback" => "authentications#create"
  match "/reset/:id/:reset_code", :to=>"users#reset", :as=>"reset"
  match '/activate/:id/:activation_code', :to=>"users#activation", :as=>"activate"
  match "/activate_user/:id", :to=>"users#activate", :as=>"activate_user"
  match "/auth/failure" => "pages#home"
  match "/welcome_user/:id", :to=>"users#welcome", :as=>"welcome_user"
  match "complete_session_authentication_path", :to=>"authentications#complete_session_authentication", :as=>:complete_session_authentication

  resources :messages
  resources :pmessages
  resources :admins
  resources :users
  resources :pages
  resources :authentications
  resources :sessions,   :only => [:new, :create, :destroy]
  resources :adminsessions,   :only => [:new, :create, :destroy]
  resources :bids
  resources :jobtypes
  resources :comments

  resources :jobs do
      member do
        post :request
      end
  end
  resources :jobphotos

  root :to => 'pages#home'

end
