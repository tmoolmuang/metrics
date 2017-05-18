Rails.application.routes.draw do
  devise_for :users
  
  get 'home/index'
  get 'home/contact'
  root 'home#about'

end
