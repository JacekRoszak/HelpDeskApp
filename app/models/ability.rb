# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, token)
    user ||= User.new
    logged_in = !user.new_record?

    if logged_in
    else
    end
  end
end
