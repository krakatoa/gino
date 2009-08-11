ActionController::Routing::Routes.draw do |map|
  map.resource :users, :path_prefix => '/:locale'

  map.resources :news, :path_prefix => '/:locale'
  map.resources :news

  map.about "/about", :controller => "home", :action => "about", :path_prefix => "/:locale"

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy', :path_prefix => '/:locale'

  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'

  map.my_account '/my_account', :controller => 'users', :action => 'edit'

  map.root :controller => "news", :path_prefix => "/:locale"
  map.root :controller => "news"

  map.resource :user_session, :path_prefix => "/:locale"
  map.resource :user_session
end
