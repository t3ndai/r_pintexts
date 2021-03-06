Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'health/index'
  resources :users, only: [:show, :create, :update]
  resources :tokens, only: [:create]
  resources :snippets, only: [:index, :show, :create, :destroy]
  resources :collections, only: [:index, :show, :create, :destroy]
  resources :collections do 
    member do 
      post 'snippet'
    end
  end
  delete '/collections/:id/:snippet_id', to: 'collections#snippet_remove'
end
