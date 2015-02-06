StoryBuilder::Application.routes.draw do
  resources :sentences, except: [:edit, :update, :index, :create] do
    resources :sentences, only: [:create]
  end
  get 'new_opening_line', to: 'sentences#new_opening_line'
  post 'create_opening_line', to: 'sentences#create_opening_line'

  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  get "/contact", to: "pages#contact", as: "contact"
  post "/emailconfirmation", to: "pages#email", as: "email_confirmation"
  
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
