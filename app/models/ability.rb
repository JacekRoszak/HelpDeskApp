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
      end
    # else
    end
  end
end
