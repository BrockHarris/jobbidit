Jobbidit::Application.routes.draw do

  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/signup', :to => 'sessions#signup'
  match '/usertype', :to => 'users#usertype'
  match '/assist', :to => 'users#assist'
  match '/jobspage', :to => 'jobs#main'
  match "/reset/:id/:reset_code", :to=>"users#reset", :as=>"reset"
  match '/settings', :to => 'users#settings'
  match "/auth/:provider/callback" => "authentications#create"
  match "/auth/failure" => "pages#home"

  resources :users
  resources :authentications
  resources :sessions,   :only => [:new, :create, :destroy]
 
  resources :jobs
  resources :bids

  root :to => 'pages#home'

end
