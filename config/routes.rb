Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, path: 'devise', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        sessions: 'search'
      },
      controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }

      # devise_scope :users do
      #   get 'devise/search', to: "sessions#search"
      # end

      resources :posts do
        resources :comments
      end

      resources :comments do 
        resources :comments
      end
    end
  end
end

