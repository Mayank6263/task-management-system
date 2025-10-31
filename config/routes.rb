Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, path: "devise", path_names: {
        sign_in: "login",
        sign_out: "logout",
        registration: "signup"

      },
      controllers: {
        sessions: "api/v1/sessions",
        registrations: "api/v1/registrations"
      }

      # devise_scope :users do
      # end
      get "posts/search", to: "posts#search"
      get "posts/myposts", to: "posts#myposts"
      get "comments/postcomments", to: "comments#postcomments"



      resources :posts do
        resources :likes
        resources :comments
      end

      resources :comments do
        resources :comments
      end
    end
  end
end
