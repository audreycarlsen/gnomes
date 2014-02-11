Gnomes::Application.routes.draw do

  root 'posts#index'

  resources :events
  resources :users
  resources :posts

  get '/auth/twitter',                                   as: 'sign_in'
  get '/sign_out',                to: 'session#destroy', as:'sign_out'
  get '/auth/:provider/callback', to: 'session#create'
  post '/events/:id/join' => "events#join", as: :join
  delete '/events/:id/not_going' => "events#not_going", as: :not_going

  if Rails.env == "test"
    get 'dummy/test_current_user' => 'dummy#test_current_user'
  end
end
