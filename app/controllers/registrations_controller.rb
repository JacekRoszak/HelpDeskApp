class RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to new_user_session_path
  end

  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password", "password", "password_confirmation"))
  end
end
