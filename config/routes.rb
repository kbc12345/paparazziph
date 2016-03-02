Rails.application.routes.draw do
  root :to => "site/welcome#index"

  # get '/home' => 'site/home#index'
  # root to: 'users#index', via: :get
  get '/auth/facebook', as: "auth_provider"
  get '/auth/facebook/callback', to: 'site/users#login'
  
  resources :users, only: [:index], controller: 'site/users'
  resources :reviews, only: [:index], controller: 'site/reviews'
  resources :contact, only: [:index], controller: 'site/contact'
  resources :home, only: [:index], controller: 'site/home'
  resources :packages, only: [:index], controller: 'site/packages'
  resources :about, only: [:index], controller: 'site/about'
  resources :bookings, only: [:create], controller: 'site/bookings'
  resources :questions, only: [:create], controller: 'site/questions'
  resources :booking_submitted, only: [:index], controller: 'site/booking_submitted'

  resources :gallery, only: [:index], controller: 'site/gallery' do
    resources :albums, only: [:index], controller: 'site/albums' do
      resources :photos, only: [:index], controller: 'site/photos'
    end
  end
  


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'home#index'

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
