Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  resources :ideas do 

    resources :reviews, only:[:create, :edit, :destroy]

    resources :likes, shallow: true, only: [:create, :destroy]
    
  end

  resource :session, only:[:new, :create, :edit, :update, :destroy]

  resource :users, only:[:new, :create, :edit, :update]

 # resources :likes, only: [:create, :destroy]

  # Defines the root path route ("/")
  root "ideas#index"
end
