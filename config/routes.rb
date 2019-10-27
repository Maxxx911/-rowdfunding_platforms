Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :sign_up, to: 'users#create'
      post :sign_in, to: 'users#sign_in'
      resources :users, only: %i[update edit] do
        member do
          patch :change_password
        end
      end
      resources :projects, only: %i[create]
    end
  end
end
