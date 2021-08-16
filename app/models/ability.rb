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
        can :manage, ServiceRequest, user_id: user.id
        can :read, ServiceRequest, department_id: user.department_id
      end
    # else token!
    end
  end
end
