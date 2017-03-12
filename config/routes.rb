Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "game#index"

  get "/results", to: "results#index"

  resources :votes
end
