require 'resque/server'

Gnomes::Application.routes.draw do

  mount Resque::Server, :at => "/resque"

  root 'welcome#index'

  get   "welcome/index"
  get   'admin',         to: 'admin#index',   as: 'admin'
  patch 'admin/:id/create',  to: 'admin#create',  as: 'create_admin'
  patch 'admin/:id/destroy', to: 'admin#destroy', as: 'destroy_admin'

  resources :events
  resources :users
  resources :posts
  resources :tools

  get '/auth/twitter',                                      as: 'sign_in'
  get '/sign_out',                 to: 'session#destroy',   as: 'sign_out'
  get '/auth/:provider/callback',  to: 'session#create'
  post '/events/:id/:response',    to: "events#rsvp",       as: 'rsvp'
  delete '/events/:id/no',         to: "events#rsvp_no",    as: 'rsvp_no'
  patch '/tools/:id/reserve',      to: 'tools#reserve_tool',as: 'reserve_tool'
  patch '/tools/:id/return',       to: 'tools#return_tool', as: 'return_tool'

  if Rails.env == "test"
    get 'dummy/test_current_user' => 'dummy#test_current_user'
    get 'dummy/test_authorize'    => 'dummy#test_authorize'
    get 'dummy/test_set_weather'  => 'dummy#test_set_weather'
  end
end
