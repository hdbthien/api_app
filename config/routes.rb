Rails.application.routes.draw do
  namespace :api do
    post "auth/login", to: "authentication#authenticate"
    post "signup", to: "users#create"
  end
end
