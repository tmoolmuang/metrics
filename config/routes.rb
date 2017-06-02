Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    match '/events', to: 'events#preflight', via: [:options]
    resources :events, only: [:create]
  end
  
  resources :apps do
    collection do
      get 'myapps'
      get 'demoapps'
    end
  end

  devise_for :users
  
  get 'home/contact'
  root 'home#about'
end
