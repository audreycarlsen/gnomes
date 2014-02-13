require 'resque/server'

Gnomes::Application.routes.draw do

  mount Resque::Server, :at => "/resque"

  root 'posts#index'

  resources :events
  resources :users
  resources :posts
  resources :tools

  get '/auth/twitter',                                   as: 'sign_in'
  get '/sign_out',                to: 'session#destroy', as: 'sign_out'
  get '/auth/:provider/callback', to: 'session#create'
  post '/events/:id/:response'    => "events#rsvp",      as: 'rsvp'
  delete '/events/:id/no'         => "events#rsvp_no",   as: 'rsvp_no'

  if Rails.env == "test"
    get 'dummy/test_current_user' => 'dummy#test_current_user'
  end
end
