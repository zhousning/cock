Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  devise_scope :user do
    get 'forget', to: 'users/passwords#forget'
    patch 'update_password', to: 'users/passwords#update_password'
  end

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :controls, :only => [:index]
  resources :templates do
    get :produce, :on => :member
  end

  resources :notices

  resources :statistics, :only => [:index] do
    get :line, :on => :collection
    get :series, :on => :collection
    get :column, :on => :collection
    get :pie, :on => :collection
    get :bar, :on => :collection
    get :area, :on => :collection
    get :scatter, :on => :collection
  end

  resources :systems, :only => [] do
    get :send_confirm_code, :on => :collection
  end

  resources :users, :only => []  do
    get :center, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
    get :mobile_authc_new, :on => :member
    post :mobile_authc_create, :on => :member
    get :mobile_authc_status, :on => :member
  end

  resources :orders, :only => [:new, :create] do
    get :pay, :on => :collection
    get :alipay_return, :on => :collection
    post :alipay_notify, :on => :collection
  end

  resources :tasks, :only => [] do
    get :invite, :on => :collection
  end

  resources :accounts, :only => [:edit, :update] do
    get :recharge, :on => :collection 
    get :info, :on => :collection
    get :status, :on => :collection
  end

  resources :roles

  resources :spiders do
    get :start, :on => :member
  end
  resources :selectors

  root :to => 'home#index'
end
