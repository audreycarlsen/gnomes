Gnomes::Application.routes.draw do

  root 'posts#index'
  
  resources :events
  resources :users
  resources :posts

  get '/auth/twitter',                                   as: 'sign_in'
  get '/sign_out',                to: 'session#destroy', as:'sign_out'
  get '/auth/:provider/callback', to: 'session#create'

  if Rails.env == "test"
    get 'dummy/test_current_user' => 'dummy#test_current_user'
  end
end
