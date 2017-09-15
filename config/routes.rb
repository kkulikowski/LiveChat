Rails.application.routes.draw do
  get 'home/index'
  
  devise_for :users
  
  root 'home#index'
  get '/chat', to: 'chat#index'
  scope :chat do
    resources :conversations, only: [:create] do
      member do
        post :close
      end
      resources :messages, only: [:create]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
