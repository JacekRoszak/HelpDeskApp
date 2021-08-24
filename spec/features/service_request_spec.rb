require 'rails_helper'

RSpec.feature ServiceRequest, driver: :selenium_chrome, js: true do
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

  context 'User' do
    before do
      sign_in @user
      visit '/service_requests'
    end

    scenario 'cannot list requests without signing in' do
      @user.destroy
      visit '/service_requests'

      expect(page).to have_content 'You are not authorized to access this page.'
      expect(current_path).to eq(new_user_session_path)
    end

    scenario 'lists his requests' do
      expect(page).to have_content 'Service requests'
      expect(page).to have_content @users_service_request.name
    end

    scenario 'cannot list other users requests' do
      expect(page).to have_content 'Service requests'
      expect(page).not_to have_content @another_users_service_request.name
    end

    scenario 'can edit his reqest' do
      expect(page).to have_content 'Service requests'
      expect(page).to have_content @users_service_request.name

      find("#sr#{@users_service_request.id}")
      expect(page).to have_content 'Dupsko'
      # link(nil, href: edit_service_request_path(@users_service_request))
    end

    scenario 'can delete his reguest'
  end

  context 'Technician' do
    before do
      sign_in @technician
      visit '/service_requests'
    end

    scenario 'lists all requests directed to his department' do
      expect(page).to have_content 'Service requests'
      expect(page).to have_content @users_service_request.name
      expect(page).not_to have_content @another_users_service_request.name
    end

    scenario 'adds his request' do
      
    end

    scenario 'edits his own request'
    scenario 'delets his own request'
    scenario 'cannot edit other user request'
    scenario 'cannot delete other user request'
    scenario 'takes a request'
    scenario 'processes a request'

  end
  
end
