require 'resque/server'

Gnomes::Application.routes.draw do

  get "welcome/index"
  mount Resque::Server, :at => "/resque"

  root 'welcome#index'

  resources :events
  resources :users
  resources :posts
  resources :tools

  get '/auth/twitter',                                    as: 'sign_in'
  get '/sign_out',                 to: 'session#destroy', as: 'sign_out'
  get '/auth/:provider/callback', to: 'session#create'
  patch '/events/:id/:response'     => "events#rsvp",      as: 'rsvp'
  delete '/events/:id/no'          => "events#rsvp_no",   as: 'rsvp_no'
  patch '/tools/:id/reserve',      to: 'tools#reserve_tool',   as: 'reserve_tool'
  patch '/tools/:id/return',       to: 'tools#return_tool',    as: 'return_tool'

  if Rails.env == "test"
    get 'dummy/test_current_user' => 'dummy#test_current_user'
    get 'dummy/test_authorize'    => 'dummy#test_authorize'
    get 'dummy/test_set_weather'  => 'dummy#test_set_weather'
  end
end
