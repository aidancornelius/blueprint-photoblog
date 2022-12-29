Rails.application.routes.draw do
  devise_for :users
  
  resources :posts do
    get '/page/:page', action: :index, on: :collection
  end
  
  # these two must go last for the above routes to be valid
  get '/:year/:slug', to: 'posts#show' # Year is not used because the slug must be unique (could be improved)
  root "posts#index"
end
