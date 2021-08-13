Rails.application.routes.draw do

  root to: 'books#index'
  devise_for :users, :controllers => {
    :registrations => "users/registrations"
  }
  get '/users', to:'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  resources :books, :except => :index
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
