Gnomes::Application.routes.draw do
  root 'users#index'

  resources :users

  get '/auth/twitter',            as: 'sign_in'
  get '/auth/:provider/callback', to: 'session#create'
end
