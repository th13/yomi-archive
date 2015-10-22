Rails.application.routes.draw do
  root 'pages#home'

  resources :sentences, only: [ :index, :show ]   # For now
end
