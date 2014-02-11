Gnomes::Application.routes.draw do

  root 'posts#index'

  get '/auth/twitter',                                   as: 'sign_in'
  get '/sign_out',                to: 'session#destroy', as:'sign_out'
  get '/auth/:provider/callback', to: 'session#create'

  resources :users
  resources :posts
end
