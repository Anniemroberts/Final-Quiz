Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'auctions#index'

  resources :auctions, shallow: true do
    patch :publish
    resources :bids, only: [:create]
    resources :watches, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create] do
    resources :watches, only: [:index]
    resources :bids, only: [:index]
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
