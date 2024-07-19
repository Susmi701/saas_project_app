class HomeController < ApplicationController

  def index
    if current_user
      @tenant = ActsAsTenant.current_tenant
      params[:tenant_id] = @tenant.id
    end
  end

end
