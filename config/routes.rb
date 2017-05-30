Rails.application.routes.draw do
  get 'events/show'

  get 'events/new'

  get 'events/edit'

  get 'events/destroy'

  get 'posts/show'

  get 'posts/new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

  get 'posts/destroy'

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
