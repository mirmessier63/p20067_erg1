Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :registrations, only: [:new, :create]

  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  get "/" => "pages#home", as: "home"
  get "register" => "registrations#new", as: "register"
  get "forum" => "forum#forum", as: "forum"
  get "google_auth" => "registrations#google", as: "google_authorizer"
  get "google_success" => "registrations#google_success"

  resources :posts, only: [:index, :new, :show, :create]

  get "forum/course_discussion" => "forum#course_discussion", as: "course_discussion"
  get "forum/project_discussion" => "forum#project_discussion", as: "project_discussion"
  get "forum/hobbies" => "forum#hobbies", as: "hobbies"
  get "forum/search" => "forum#search", as: "search"

  get "forum/course_discussion/:thread" => "forum#thread", as:"cd_get_thread"
  get "forum/project_discussion/:thread" => "forum#thread", as:"pd_get_thread"
  get "forum/hobbies/:thread" => "forum#thread", as:"h_get_thread"

  get "users" => "users#users", as: "users"
  get "friend_request" => "users#friend_request", as: "friend_request"
  get "accept" => "users#accept", as: "accept"
  get "reject" => "users#reject", as: "reject"

  post "create_conversation" => "messages#create_conversation"
  post "get_chat" => "messages#get_chat"
  post "send_message" => "messages#send_message"

  get "delete_notification" => "pages#delete_notification", as: "delete_notification"
end
