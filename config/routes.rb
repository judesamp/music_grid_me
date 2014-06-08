Rails.application.routes.draw do
  root 'welcome#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :users
  resources :taste_profiles

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post "login" => "users#session_create"
          post "logout" => "users#session_destroy"
          post "check_token" => "users#check_token"
          post "create" => "users#create"
        end
      end
      post "get_albums" => "taste_profiles#get_albums"
      resources :taste_profiles do
        collection do
          post "get_three_suggestions" => "taste_profiles#get_three_suggestions"
          
        end
      end
    end
  end
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
  get "dashboard" => "users#dashboard"
  get "/auth/:provider/callback" => "sessions#omniauth_create"
  get "/signout" => "sessions#omniauth_destroy", :as => :signout
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
