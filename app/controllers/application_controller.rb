class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :set_tenant

  private
  def set_tenant
    if current_user
      ActsAsTenant.current_tenant = current_user.tenant
      
    end
  end
end