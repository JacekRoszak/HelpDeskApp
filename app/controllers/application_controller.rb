class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_url, alert: exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:token])
  end

end
