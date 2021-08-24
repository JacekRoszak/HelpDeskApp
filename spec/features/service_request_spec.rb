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
    @users_second_service_request = ServiceRequest.create!(name: 'second request', request_status_id: @request_status.id, user_id: @user.id, location_id: @location.id, department_id: @technicians_department.id)
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

    scenario 'can create a new request'

    scenario 'can edit his reqest' do
      find("#sr#{@users_service_request.id}") # wait for buttons to appear
      expect(page).to have_link(nil, href: edit_service_request_path(@users_service_request))
      click_link nil, href: edit_service_request_path(@users_service_request)

      find("#edit_service_request_#{@users_service_request.id}") # wait for form
      within 'form', id: "edit_service_request_#{@users_service_request.id}" do
        fill_in 'service_request[name]', with: 'This is a new name'
        click_button 'commit'
      end
      find("div[data-requests-url-value='#{service_request_btn_path(service_request_id: @users_service_request.id)}']") # wait for show action
      @users_service_request.reload
      expect(@users_service_request.name).to eq 'This is a new name'
    end

    scenario 'can delete his reguest' do
      number_of_requests = ServiceRequest.count
      find("#sr#{@users_service_request.id}") # wait for buttons to appear
      within 'div', id: "sr#{@users_service_request.id}" do
        expect(page).to have_link(nil, href: service_request_path(@users_service_request))
        accept_alert do
          click_link nil, href: service_request_path(@users_service_request)
        end
      end

      find(".alerts") # wait alert
      expect(ServiceRequest.count).to eq(2)
    end
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
