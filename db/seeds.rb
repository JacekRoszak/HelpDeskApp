User.destroy_all
RequestStatus.destroy_all
Department.destroy_all
Location.destroy_all

# Status of a service request
[
  { name: 'Waiting', color: '', background: '' },
  { name: 'Assigned', color: '', background: '' },
  { name: 'In progress', color: '', background: '' },
  { name: 'On hold', color: '', background: '' },
  { name: 'Finished', color: '', background: '' },
  { name: 'Cancelled', color: '', background: '' }
].each { |status_params| RequestStatus.create!(status_params) }

# Departments in our company
[
  { name: 'IT' },
  { name: 'Electrics' },
  { name: 'Mechanics' },
  { name: 'Bookkeepers' },
  { name: 'HR' },
  { name: 'Sales' },
  { name: 'Supply' },
  { name: 'Production' }
].each { |department_params| Department.create!(department_params) }

# Locations in our company
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

# Users
[
  { email: 'admin@gmail.com', first_name: 'admin', last_name: 'admiński', password: 'admin123', department_id: Department.find_by(name:'IT').id, admin?: true },
  { email: 'user@gmail.com', first_name: 'user', last_name: 'userski', password: 'user123', department_id: Department.find_by(name:'HR').id }
].each do |user_params| 
  user = User.new(user_params)
  user.skip_confirmation!
  user.save
end

