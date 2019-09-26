Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :sign_up, to: 'users#create'
      post :sign_in, to: 'users#sign_in'
      get :profile, to: 'users#edit'
      resources :users, only: %i[update]
    end
  end
end
