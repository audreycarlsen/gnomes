Gnomes::Application.routes.draw do
  resources :posts

  root 'users#index'

  resources :users

  get '/auth/twitter',            as: 'sign_in'
  get '/auth/:provider/callback', to: 'session#create'
end
