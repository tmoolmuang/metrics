Rails.application.routes.draw do
   resources :apps do
    collection do
      get 'myapps'
      get 'demoapps'
    end
  end

  devise_for :users
  
#   get 'apps' => 'home/index'
  get 'home/contact'
  root 'home#about'
 
end
