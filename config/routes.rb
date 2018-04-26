Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    post "auth/login", to: "authentication#authenticate"
    post "signup", to: "users#create"
    patch "upgrade_user", to: "users#upgrade_user"
    namespace :v1 do
      resources :orders, only: %i(index show create)
      resources :products
    end
  end
end
