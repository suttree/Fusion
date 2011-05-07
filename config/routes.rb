ActionController::Routing::Routes.draw do |map|
  map.resources :users

  map.resource :user_session
  map.resource :account, :controller => 'users'
  map.resource :play, :controller => 'play'

  map.connect '/play/next', :controller => 'play', :action => 'next'

  map.root :controller => 'home', :action => 'index'
end
