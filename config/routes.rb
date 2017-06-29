ActionController::Routing::Routes.draw do |map|
  map.resource :program
  map.resource :comment
  map.root :controller => "surveys"

  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
