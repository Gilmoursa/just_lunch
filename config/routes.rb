Rails.application.routes.draw do
  root 'sessions#index'

  resources :restaurants, only: [:show]
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :meetings, only: [:index, :show, :edit, :destroy]
    resources :invitations, only: [:show, :new, :create, :destroy, :update, :index]
    resources :availability, only: [:new, :create, :edit, :update, :show]
  end

  get '/signup', to: 'users#new', as: "signup"
  get '/login', to: 'sessions#new', as: "login"
  get '/logout', to: 'sessions#destroy', as: "logout"
  post '/sessions', to: 'sessions#create', as: "post_login"
  
  # get '/invitations', to: 'invitations#index', as: 'invitations'
  get '/admin', to: 'invitations#admin', as: 'admin'
  post '/invitations', to: 'invitations#create', as: 'create_invitations'
  get '/construction', to: 'sessions#construction', as: 'construction'

  # resources :

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
