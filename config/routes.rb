Rails.application.routes.draw do
  resources :patients do
    collection do
      post :import
      get :progress
    end
  end
  root "patients#index"
end
