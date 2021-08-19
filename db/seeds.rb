puts 'Destroing'
ServiceRequest.destroy_all
User.destroy_all
RequestStatus.destroy_all
Department.destroy_all
Location.destroy_all

puts 'Request Status'
[
  { name: 'Waiting' },
  { name: 'Assigned' },
  { name: 'In progress' },
  { name: 'On hold' },
  { name: 'Finished' },
  { name: 'Cancelled' }
].each { |status_params| RequestStatus.create!(status_params) }

puts 'Departments'
[
  { name: 'IT', technicians?: true },
  { name: 'Electrics' },
  { name: 'Mechanics' },
  { name: 'Bookkeepers' },
  { name: 'HR' },
  { name: 'Sales' },
  { name: 'Supply' },
  { name: 'Production' }
].each { |department_params| Department.create!(department_params) }

puts 'Locations'
[
  { name: 'IT office' },
  { name: 'Electrics workshop' },
  { name: 'Mechanics' },
  { name: 'Bookkeeping' },
  { name: 'Gate nr1' },
  { name: 'Gate nr2' },
  { name: 'Production hal nr 1' },
  { name: 'Production' }
].each { |location_params| Location.create!(location_params) }

puts 'Users'
[
  { email: 'admin@gmail.com', first_name: 'admin', last_name: 'admiński', password: 'admin123', department_id: Department.find_by(name:'IT').id, admin?: true },
  { email: 'user@gmail.com', first_name: 'Adam', last_name: 'Nowak', password: 'user123', department_id: Department.find_by(name:'HR').id },
  { email: 'it@gmail.com', first_name: 'Robert', last_name: 'Lewandowski', password: 'user123', department_id: Department.find_by(name:'IT').id },
  { email: 'user2@gmail.com', first_name: 'Krzysiek', last_name: 'Kowalski', password: 'user123', department_id: Department.find_by(name:'HR').id }
].each do |user_params|
  user = User.new(user_params)
  user.skip_confirmation!
  user.save
end

puts 'Requests'
[
  { name: 'There is a printer problem in our office. It makes strange sounds and does not print. Please help!',
    request_status_id: RequestStatus.all[0].id, user_id: User.all[1].id, location_id: Location.all.sample.id, department_id: Department.find_by(name: 'IT').id },
  { name: 'Need help with out workflow! It hangs since this morning!',
    request_status_id: RequestStatus.all[1].id, user_id: User.all[3].id, location_id: Location.all.sample.id, department_id: Department.find_by(name: 'IT').id },
  { name: 'Something is wrong with my computer! Everything freezed and mouse is not responding!',
    request_status_id: RequestStatus.all[2].id, user_id: User.all[3].id, location_id: Location.all.sample.id, department_id: Department.find_by(name: 'IT').id },
  { name: 'A problem with keyboard. Some keys doesnt work :(',
    request_status_id: RequestStatus.all[3].id, user_id: User.all[3].id, location_id: Location.all.sample.id, department_id: Department.find_by(name: 'IT').id },
  { name: 'There is a new guy in our department. Please create a domain accout for him.',
    request_status_id: RequestStatus.all[4].id, user_id: User.all[1].id, location_id: Location.all.sample.id, department_id: Department.find_by(name: 'IT').id }
].each { |sr_params| ServiceRequest.create! sr_params }

puts 'End'