Gnomes::Application.routes.draw do
  get '/auth/twitter',            as: 'sign_in'
  get '/auth/:provider/callback', to: 'session#create'
end
