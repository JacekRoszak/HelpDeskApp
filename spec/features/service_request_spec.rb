require 'rails_helper'

RSpec.feature ServiceRequest do
  before do
    @department = Department.create(name: 'HR')
    @request_status = RequestStatus.create(name: 'status')
    @location = Location.create(name: 'location')
    @user = User.new(email: 'test@example.com', password: 'password', department_id: @department.id)
    @user.skip_confirmation!
    @user.save
  end

  let(:users_service_request) { ServiceRequest.create(name: 'test request', request_status_id: @request_status.id, user_id: @user.id, location_id: @location.id) }

  scenario 'User cannot list requests without signing in' do
    @user.destroy
    visit '/service_requests'

    expect(page).to have_content 'You are not authorized to access this page.'
    expect(current_path).to eq(new_user_session_path)
  end

  context 'Signed in' do
    before do
      sign_in @user
    end

    scenario 'User lists requests' do
      visit '/service_requests'

      expect(page).to have_content 'Service requests list'
    end
  end
end
