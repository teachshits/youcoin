Youcoin::Application.routes.draw do

  resources :tags


  devise_for :users

#  cancel_user_registration_path GET    /users/cancel(.:format)                  devise/registrations#cancel
#  user_registration_path POST   /users(.:format)                        devise/registrations#create
#  new_user_registration GET    /users/sign_up(.:format)                devise/registrations#new
#  edit_user_registration_path GET    /users/edit(.:format)                   devise/registrations#edit

  match '/signup',	:to => 'devise/registrations#new'
  
  

  resources :cashes

  resources :payments
  
  resource :transfer

  resources :categories

  root :to => 'home#index'
  
  get "cashes/add_payment"
  
  post "cashes/add_transfer"
  
  post "cashes/balance_edit"
  
  
  
  resources :cashes do
      member do
       post 'add_transfer'
      end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controller[Ds/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
