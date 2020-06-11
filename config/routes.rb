Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      post '/sign_up', to: 'users#sign_up'
      post '/login', to: 'users#login'

      resources :books, only: %i(index create update)
    end
  end
end
