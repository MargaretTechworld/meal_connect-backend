Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "user_profile", to: "members#index"
  get "meals_available", to: "api/v1/meals#meals_available"

  namespace :api do
    namespace :v1 do
      resources :meals do
        resources :reservations, only: [:create]
        member do
          patch "update_availability"
        end
      end
      resources :reservations, only: [:index, :show, :destroy]
    end
  end
end
