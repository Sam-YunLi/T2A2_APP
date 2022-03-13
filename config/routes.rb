Rails.application.routes.draw do
  get 'games/index'
  get 'games/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"

  get '/restricted', to: "pages#restricted"
  get '/games', to: "games#index", as: 'games'

  post '/games', to: "games#create"
  get '/games/new', to: "games#new", as: 'new_game'

  get '/games/:id', to: "games#show", as: 'game'

  put '/games/:id', to: "games#update"
  patch '/games/:id', to: "games#update"

  delete '/games/:id', to: "games#destroy", as: "delete_game"

  get '/games/:id/edit', to: "games#edit", as: 'edit_game'

end
