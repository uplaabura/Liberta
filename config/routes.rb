Rails.application.routes.draw do

  #root to: 'crews#index', via: :get
  #get 'auth/facebook', as: "auth_provider"
  #get 'auth/facebook/callback', to: 'crews#login'

  #devise for users functioning (crew)
  devise_for :crews, :controllers => { :omniauth_callbacks => "facebook_callbacks" }

  devise_scope :crew do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_crew_session_path
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_crew_session_path
  end
  
  #devise_scope :crew do
    #delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session_path
  #end

  # Omniauth for facebook
  #get '/auth/:facebook/callback', to: 'sessions#create'
  
  resources :articles do
    resources :comments
    #resource :like
    #resource :grade
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'home#index'
  root 'home#index'

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
