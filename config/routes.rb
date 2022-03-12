Rails.application.routes.draw do
  get 'games/index'
  get 'games/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "pages#home"
  get '/restricted', to: "pages#restricted"
  get '/games', to: "games#index", as: 'games'
  get '/games/:id', to: "games#show", as: 'game'

end
