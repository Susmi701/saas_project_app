# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    ActiveRecord::Base.transaction do
      super do |resource|
        debugger
        if resource.persisted?
          tenant = Tenant.new(tenant_params)
          tenant.save!  # Save tenant and raise exception if fails

          resource.update!(tenant: tenant)
          ActsAsTenant.current_tenant = tenant

          # Ensure tenant is created successfully and associate with user
        else
          raise ActiveRecord::RecordInvalid.new(resource)  # Raise exception to trigger rollback
        end
      end
    rescue StandardError => e
      # Handle exceptions and rollback tenant creation
      logger.error "Registration failed: #{e.message}"
      ActsAsTenant.current_tenant&.destroy # Clean up tenant if user registration fails
      resource.destroy if resource.persisted? # Remove user if creation was successful but tenant was not
      redirect_to new_user_registration_url, alert: 'Registration failed. Please try again.' and return
    end
  end

  protected

  def tenant_params
    params.require(:tenant).permit(:name, :plan)
  end
  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
