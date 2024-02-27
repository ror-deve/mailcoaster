require 'sidekiq/web'
Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  mount ActionCable.server => '/cable'
  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end
  root to: "home#index"
  devise_for :users, path: "", controllers: { registrations: "users/registrations", sessions: "users/sessions"}, path_names: { sign_in: 'login', password: 'forgot', sign_up: 'register', sign_out: 'signout'}
  
  


  devise_scope :user do
    # Redirests signing out users back to sign-in
    get "users", to: "devise/sessions#new"
  end
  
  resources :users do
    collection do
      get '/:username' => 'users#profile'
      post 'upload_avatar' => 'users#upload_avatar'
      post 'change_password' => 'users#change_password'
      patch 'update_profile' => 'users#update_profile'
    end
  end

  resources :accounts do
    # resources :campaigns
    resources :content_images, only: [:new, :create, :destroy]
    resources :folders do
      collection do
        get :form_folders
      end
    end
    # resources :campaigns do
    #   member do
    #     get :preview
    #   end
    #   collection do
    #     post '/new' => "content_templates#new", :as => :new
    #     get  :new_template
    #     get  :choose_editor
    #     get  :new_template_permissions
    #   end
    # end

    resources :campaigns do
      resources :steps, only: [:show, :update], controller: 'campaigns'
      member do
        get :preview
        # get :step1
        # get :step2
        # get :step3
        # get :step4
      end
      collection do
        get  :new_template
        get  :choose_editor
        get  :new_template_permissions
      end
    end

    resources :contents do
      member do
        get :preview
      end
      collection do
        post '/new' => "content_templates#new", :as => :new
        get  :new_template
        get  :choose_editor
        get  :new_template_permissions
      end
    end
    resources :content_templates do
      member do
        get :preview
        get :edit_template_permissions
        get :page
      end
      collection do
        post '/new' => "content_templates#new", :as => :new
        get  :new_template
        get  :choose_editor
        get  :new_template_permissions
      end
    end
    resources :domains do
      member do
        post 'verify_dns_entries' => "domains#verify", :as => :verify
      end
    end
    resources :lists do
      member do
        get  :import
        post  :upload_csv
      end
    end
  end
end
