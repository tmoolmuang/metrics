Rails.application.routes.draw do
  resources :apps do
    resources :events, except: [:index]
    collection do
      get 'myapps'
      get 'demoapps'
    end
  end

  devise_for :users
  
  get 'home/contact'
  root 'home#about'
end
