class TenantsController < ApplicationController
  #before_action :set_tenant, only: [ :edit, :update, :destroy]

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    debugger
    if @tenant.save
      # Optionally, send confirmation email after creation
      redirect_to @tenant, notice: "Tenant created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :plan)
    
  end

  # def invite_members(tenant, invite_emails)
  #   invite_emails.split(",").each do |email|
  #     user = User.invite!(email: email.strip)
  #     user.add_role(:member, tenant) # Assuming you use a role-based system
  #   end
  # end
end
