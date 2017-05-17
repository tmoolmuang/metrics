Rails.application.routes.draw do
  get 'home/index'
  get 'home/contact'
  root 'home#about'

end
