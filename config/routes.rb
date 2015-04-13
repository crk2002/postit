PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  
  resources :users, only: [:create, :show, :edit, :update] do
    get 'get_two_auth', on: :member
    post 'verify_two_auth', on: :member
  end
  
  
  
  
  resources :posts, except: :destroy do
    member do
      post 'vote'
    end
    resources :comments, only: :create do
      member do
        post 'vote'
      end
    end
  end
  resources :categories, only: [:new, :create, :show]
end
