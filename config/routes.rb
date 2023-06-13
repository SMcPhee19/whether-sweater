Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      post :users, to: 'users#create'
    end
  end
end
