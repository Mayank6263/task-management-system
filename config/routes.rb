Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'api/v1/sessions',
        registrations: 'api/v1/registrations'
      }

      resources :posts do 
        resources :comments
      end

      resources :comments do 
        resources :comments
      end
    end
  end
end
