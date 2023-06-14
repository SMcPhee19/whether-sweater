Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :forecast, only: [:index]
      post :users, to: 'users#create'
      post :sessions, to: 'sessions#create'
      post :road_trip, to: 'road_trip#create'
    end

    namespace :v1 do
      get 'book-search', to: 'book_search#index'
    end
  end
end
