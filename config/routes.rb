Rails.application.routes.draw do
  root to: "user#index"
  get "users/:id", to: "user#show_users", as: "show_users"
  post "users", to: "user#create_user"
  post "invited_code/:id", to: "user#check_code", as: "invited_code"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
