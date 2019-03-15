Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages do
    collection do 
      get 'search'
    end
    resources :comments
   
    member do
      get 'like', to: "messages#like"
      get 'unlike', to: "messages#unlike"
    end
  end
  resources :categories
  get '/about', to: 'pages#about'
  root 'messages#index'
end
