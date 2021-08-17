require 'rails_helper'

RSpec.feature ServiceRequest do
  before do
    @department = Department.create!(name: 'HR', technicians?: false)
    @technicians_department = Department.create!(name: 'IT', technicians?: true)
    @request_status = RequestStatus.create!(name: 'status')
    @location = Location.create!(name: 'location')

    @user = User.new(email: 'test@example.com', password: 'password', department_id: @department.id, admin?: false)
    @user.skip_confirmation!
    @user.save

    @another_user = User.new(email: 'another_user@example.com', password: 'password', department_id: @department.id)
    @another_user.skip_confirmation!
    @another_user.save

    @technician = User.new(email: 'technician@example.com', password: 'password', department_id: @technicians_department.id)
    @technician.skip_confirmation!
    @technician.save

    @users_service_request = ServiceRequest.create!(name: 'test request', request_status_id: @request_status.id, user_id: @user.id, location_id: @location.id, department_id: @technicians_department.id)
    @another_users_service_request = ServiceRequest.create!(name: 'another request', request_status_id: @request_status.id, user_id: @another_user.id, location_id: @location.id, department_id: @department.id)
  end

  scenario 'User cannot list requests without signing in' do
    @user.destroy
    visit '/service_requests'

    expect(page).to have_content 'You are not authorized to access this page.'
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'User lists his requests' do
    sign_in @user
    visit '/service_requests'

    expect(page).to have_content 'Service requests'
    expect(page).to have_content @users_service_request.name
  end

  scenario 'User doesnt list other users requests' do
    sign_in @user
    visit '/service_requests'

    expect(page).to have_content 'Service requests'
    expect(page).not_to have_content @another_users_service_request.name
  end

  scenario 'Technician lists all requests directed to his department' do
    sign_in @technician
    visit '/service_requests'

    expect(page).to have_content 'Service requests'
    puts "############## #{@technician.technician?}"
    expect(page).to have_content @users_service_request.name
    expect(page).not_to have_content @another_users_service_request.name
  end
end
