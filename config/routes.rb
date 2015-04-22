Rails.application.routes.draw do
  get 'student/index'
  get 'admin_portal' => 'admin#index'
  get 'instructor_portal' => 'instructor#index'
  get 'student_portal' => 'student#index'
  get 'start_class' => 'active_classes#new'
  get 'test' => 'submissions#test'
  get 'as_summery' => 'instructor#as_summery'


  controller :submissions do
    get ':id/sub_assignment', to: :new, as: 'sendassignment'
    post ':id/sub_assignment', to: :create
  end
  #controller :submissions do
  # get ':id/sub_assignment' => :sub_assignment
  #post 'sub_assignment' => :create
  #end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end


  get 'sessions/create'
  get 'sessions/destroy'
  get 'sessions/new'

  get 'portal/index'

  resources :groups

  resources :team_names

  resources :active_classes

  resources :users

  resources :assignments

  resources :submissions

  root 'portal#index'

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
