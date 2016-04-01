Rails.application.routes.draw do
  resources :users

  resource :session, except: [:edit, :update, :show]

  resources :subs
end
