class TwoFactorsController < ApplicationController
  def create
    puts "old = #{current_user.otp_required_for_login}"
    current_user.update(otp_required_for_login: true)
    current_user.otp_secret = User.generate_otp_secret
    current_user.save
    puts "new #{current_user.otp_required_for_login}"
    render 'two_factors/create.js.erb'
  end

  def destroy
    current_user.otp_required_for_login = false
    current_user.save!
    render 'two_factors/create.js.erb'
  end
end
