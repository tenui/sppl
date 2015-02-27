class UsersController < InheritedResources::Base
  before_filter :require_admin, :only => [:index]
end
