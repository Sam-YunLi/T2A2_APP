Rails.application.routes.draw do
  get 'payments/success'
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
  
  post 'payments/webhook', to: "payments#webhook"

  get 'payments/success/:id', to: "payments#success", as:"payment_success"

  post "payments", to: "payments#create_checkout_session", as: "create_checkout_session"

  # use post for the add to cart button
  post 'games/add_to_cart/:id', to: 'games#add_to_cart', as: 'add_to_cart'

  # delete from the cart
  delete 'games/remove_form_cart/:id', to: 'games#remove_form_cart', as: 'remove_form_cart'

  # clear cart
  delete 'games/clear_cart/:id', to: 'games#clear_cart', as: 'clear_cart'

  get 'games/mygame/:id', to: 'games#mygame', as: "my_game"

  get 'games/purchased/:id', to: 'games#purchased', as: "purchased"

end
