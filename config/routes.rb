Rails.application.routes.draw do
  resources :camp_instructors
  resources :camps
  resources :curriculums
  resources :locations
  resources :instructors
  resources :registrations
  resources :students
  resources :users
  resources :families
  get "/home/:home" => "home#index"
  get "about", to: "home#about"
  get "contact", to: "home#contact"
  get "privacy", to: "home#privacy"
  get "home", to: "home#home"
  get "index", to: "home#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
