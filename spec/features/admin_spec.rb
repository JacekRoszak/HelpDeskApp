require 'rails_helper'

RSpec.feature 'Admin panel' do
  before do
    @department = Department.create(name: 'IT')
    @user = User.new(email: 'test@example.com', password: 'password', department_id: @department.id)
    @user.skip_confirmation!
    @user.save

    @admin = User.new(email: 'admin@example.com', password: 'password', admin?: true, department_id: @department.id)
    @admin.skip_confirmation!
    @admin.save
  end

  scenario 'User cannot open admin panel' do
    sign_in @user
    visit '/admin'
    expect(page).to have_content 'Unauthorized: Admins only!'
  end

  scenario 'Admin can open admin panel' do
    sign_in @admin
    visit '/admin'
    expect(page).to have_content 'Dashboard'
  end
end
