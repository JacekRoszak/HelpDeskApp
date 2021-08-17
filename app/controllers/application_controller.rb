class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, alert: exception.message
  end

  def access_denied(exception)
    redirect_to root_path, alert: 'Unauthorized: Admins only!'
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:token])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name otp_attempt])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name cell_number work_number inner_number])
  end
end
