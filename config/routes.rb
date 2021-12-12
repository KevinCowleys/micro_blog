Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  # Login routes
  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get 'sign_in', to: 'sessions#new', as: :log_in
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # Password routes
  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'
  # get 'password/reset', to: 'password_resets#new'
  # post 'password/reset', to: 'password_resets#create'
  # get 'password/reset/edit', to: 'password_resets#edit'
  # patch 'password/reset/edit', to: 'password_resets#update'

  # Post routes
  get ':username/status/:id', to: 'posts#show'
  delete 'post/:id', to: 'posts#destroy', as: :post
  post 'create_post', to: 'posts#create'
  post 'like_post', to: 'posts#like'
  post 'save_post', to: 'posts#save'
  post 'share_post', to: 'posts#share'
  # post 'delete_post', to: 'posts#destroy'

  resources :conversations do
    resources :messages
  end

  # Follower routes
  get ':username/following', to: 'followers#show_following'
  get ':username/followers', to: 'followers#show_followers'
  post ':username/follow', to: 'followers#create', as: :follow_user

  # Block routes
  get 'profile/settings/blocked', to: 'blocks#show_blocked', as: :settings_blocks
  post ':username/block', to: 'blocks#create', as: :block_user

  # Mute routes
  get 'profile/settings/muted', to: 'mutes#show_muted', as: :settings_mutes
  post ':username/mute', to: 'mutes#create', as: :mute_user

  # Like routes
  get ':username/likes', to: 'likes#index', as: :likes

  # Save routes
  get ':username/saves', to: 'saves#index', as: :saves

  # Profile routes
  get ':username', to: 'profile#index', as: :profile
  get 'profile/settings', to: 'profile#settings', as: :settings
  patch 'profile/settings', to: 'profile#update_settings', as: :update_settings
end
