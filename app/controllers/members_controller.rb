class MembersController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def new
    @member = Member.new
    @user = User.new
  end

  def create
    
    @user = User.new(user_params)
    @user.tenant = current_user.tenant # Associate with current tenant
    @user.invite!(current_user)
    if @user.save
      debugger
       # Send the invitation email
      Member.create(member_params,user: @user, tenant: current_user.tenant)
      flash[:notice] = "Invitation sent to #{@user.email}."
      redirect_to root_path
    else
      flash[:error] = "Errors occurred!"
      render :new
    end
  end

  private
  def member_params
    params.require(:member).permit(:first_name, :last_name)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
