Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :patients do
    collection do
      post :import
      get :progress
    end
  end
  root "patients#index"
end
