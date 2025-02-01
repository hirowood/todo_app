Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks do
    member do
      patch :toggle
    end
  end
end
