Rails.application.routes.draw do
  resources :courses do
    resources :files, only: %i[create destroy]
  end
end