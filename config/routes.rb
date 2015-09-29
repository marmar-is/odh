Rails.application.routes.draw do
  # Active Admin
  #devise_for :admin_users, ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  #authenticated :admin_user do
  #  root 'admin/dashboard#index', as: "admin"
  #end

  # Devise Accounts
  devise_for :accounts, controllers: { registrations: 'accounts/registrations' } do
    root 'accounts#index'
  end

  authenticated :account do
    root 'accounts#index'
  end

  unauthenticated do
    root 'statics#index', :as => "unauthenticated"
  end

  #root 'statics#index'

  #get    'home'                                => 'ambassadors#index',               as: :home_page
  post   'ambassadors/refer'                   => 'ambassadors#refer',               as: :send_referrals
  patch  'ambassadors/update_prospect/:id'     => 'ambassadors#update_prospect',     as: :update_prospect
  patch  'ambassadors/update_bank_account/:id' => 'ambassadors#update_bank_account', as: :update_bank_account

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
