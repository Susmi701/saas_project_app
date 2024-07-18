class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain(:account, :subdomain)
  #set_current_tenant_through_filter
  # before_action :set_tenant
  # before_action :set_member, only: [:show, :edit, :update, :destroy]

  # def set_tenant
  #   set_current_tenant(current_user.account)
  # end
end
