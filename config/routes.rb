Rails.application.routes.draw do
  resources :comments, only: %i[edit update destroy]
  resources :reports do
    resources :comments, module: :reports, only: [:create]
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books do
    resources :comments, module: :books, only: [:create]
  end
  resources :users, only: %i[index show] do
    resource :relationships, only: %i[create destroy]
    scope module: :users do
      resources :followings, only: [:index]
      resources :followers, only: [:index]
    end
  end
end
