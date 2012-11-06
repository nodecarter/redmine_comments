ActionController::Routing::Routes.draw do |map|
  map.resources :issue_comments, :only => [:new, :create]
end
