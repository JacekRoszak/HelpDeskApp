# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, token = '')
    user ||= User.new
    logged_in = !user.new_record?
    admin = user.admin?

    if logged_in
      if admin
        can :manage, :all
      else
        # User can manage his own requests
        can :manage, ServiceRequest, user_id: user.id
        cannot :take_request, ServiceRequest
        # Technician can read a request, if it was send to his department
        if user.technician?
          can [:read, :edit, :update], ServiceRequest, department_id: user.department_id
          can :take_request, ServiceRequest, department_id: user.department_id
        end
      end
    # else token!
    end
  end
end
