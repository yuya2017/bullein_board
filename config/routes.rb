Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
  devise_scope :user do
  get 'users/registrations/edit_confirmation' => 'users/registrations#edit_confirmation'
  post 'users/guest_sign_in' =>'users/sessions#new_guest'
  end

  root to: 'posts#index'
  get 'rooms/:id' => 'rooms#show', as:'rooms'
  resources :messages, only: :create
  get 'posts/new' => 'posts#new'
  get 'posts/rec' => 'posts#rec'
  get 'posts/edit_confirmation' => 'posts#edit_confirmation'
  get 'posts/edit_change' => 'posts#edit_change'
  get 'posts/all_content' => 'posts#all_content'
  get 'posts/search_posts' => 'posts#search_posts'
  get 'posts/mypage' => 'posts#mypage'
  get 'posts/:id' =>'posts#show'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  patch 'posts/:id' => 'posts#update'
  delete 'posts/:id' => 'posts#destroy'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
