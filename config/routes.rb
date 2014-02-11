Gnomes::Application.routes.draw do
  resources :posts

  root 'posts#index'

  resources :users

  get '/auth/twitter',                                   as: 'sign_in'
  get '/auth/:provider/callback', to: 'session#create'
  get '/sign_out',                to: 'session#destroy', as:'sign_out'
end
