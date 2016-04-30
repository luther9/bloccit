Rails.application.routes.draw do
  get 'questions/edit'

  get 'questions/index'

  get 'questions/new'

  get 'questions/show'

  resources :posts

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
