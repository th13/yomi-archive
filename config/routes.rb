Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'

  resources :sentences, only: [ :index, :show ]   # For now
end
