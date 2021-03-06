ActionController::Routing::Routes.draw do |map|
  map.resources :oauth_clients

  map.test_request '/oauth/test_request', :controller => 'oauth', :action => 'test_request'
  map.token '/oauth/token', :controller => 'oauth', :action => 'token'
  map.access_token '/oauth/access_token', :controller => 'oauth', :action => 'access_token'
  map.request_token '/oauth/request_token', :controller => 'oauth', :action => 'request_token'
  map.authorize '/oauth/authorize', :controller => 'oauth', :action => 'authorize'
  map.oauth '/oauth', :controller => 'oauth', :action => 'index'
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"
  
  map.connect '', :controller => 'index'
  
  map.connect '/course/:course/assignment/:assignment/student/:student/:controller/:action/:id',
      :controller => 'home', :action => 'index', :id => nil

  map.connect '/course/:course/assignment/:assignment/:controller/:action/:id',
      :controller => 'assignment/index', :action => 'index', :id => nil

  map.connect '/course/:course/:controller/:action/:id/:file.:extension',
      :action => 'podcast_download', :id => nil  
  
  map.connect '/course/:course/:controller/:action/:id',
    :controller => 'overview', :action => 'index', :course => nil, :id => nil
    
  map.connect '/redirect/type/:type/:id',
    :controller => 'redirect', :action => 'index', :type => nil, :id => nil
    
  map.connect '/public/redirect/type/:type/:id',
    :controller => 'public/redirect', :action => 'index', :type => nil, :id => nil
  
  map.connect '/admin/course_admin/:action/:id/course/:course',
    :controller => 'admin/course_admin', :action => 'index'

  map.connect '/admin', :controller => 'admin/index'

  map.connect '/public', :controller => 'public/index'
  
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
