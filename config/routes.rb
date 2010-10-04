Sageify::Application.routes.draw do
  devise_for :users do
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
  end
  resources :scores, :assessments, :questions, :users
  
  resources :exams do
    resources :questions, :collection => {:sort => :post}
  end
  
  resources :lessons do
    resources :assigned_users
    resources :pages do
      post :sort, :on => :collection
    end
    resources :lesson_exams
  end
  
  resources :learn, :only => [:index, :show] do 
    resources :pages, :only => [:index, :show]
  end
  
  resource :about, :controller => "about",  :only => [:show]
  resource :organization

  resource :welcome, :controller => "welcome", :only => [:show]
  
  match "/signup" => "organizations#new"

  root :to => "welcome#show" 
end
